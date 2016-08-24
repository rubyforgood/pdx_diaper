ActiveAdmin.register Transfer do
  actions :all, except: [:edit, :update, :destroy]

  filter :inventory
  filter :partner
  filter :items
  filter :created_at, as: :date_range

  permit_params :from_id,
    :to_id,
    :comment,
    :containers_attributes => [:item_id, :quantity, :id, :_destroy]

  controller do
    def create
      @transfer = Transfer.new permitted_params[:transfer]
      inventory = @transfer.from
      begin
        inventory.move_inventory!(@transfer) if inventory
        if @transfer.save
          redirect_to @transfer, notice: "Successfully created new transfer"
        else
          render :new, error: "There was an error creating the transfer"
        end
      rescue Errors::InsufficientAllotment => e
        items = ""
        e.insufficient_items.each do |insufficiency|
          container = @transfer.containers.find { |c| c.item_id == insufficiency[:item_id] }
          container.quantity = insufficiency[:quantity_on_hand]
        end
        items = e.insufficient_items.map { |i| i[:item_name] }.join(", ")
        flash[:error] = "#{items} exceed available inventory and has been adjusted"
        render :new
      end
    end

    def item_params
      params["ticket"]["containers_attributes"].values.map { |entry|
        [ entry["item_id"], entry["quantity"].to_i ]
      }.to_h
    end
  end

  index do
    selectable_column
    column :id do |ticket|
      link_to ticket.id, ticket
    end
    column :from
    column :to
    column :number_of_items do |ticket|
      ticket.containers.count
    end
    column :total_quantity
    column :created_at
    actions
  end

  form do |f|
    inputs do
      input :from, :label => 'Sending Facility', :as => :select, :collection => Inventory.all
      input :to, :label => 'Receiving Facility', :as => :select, :collection => Inventory.all
      input :comment, :label => 'Comments', :as => :string
    end
    inputs 'Items' do
      f.has_many :containers, allow_destroy: true do |container|
        container.input :item_id, :label => 'Items', :as => :select, :collection => Item.all
        container.input :quantity
      end
    end
    actions
  end

  show do |ticket|
    attributes_table do
      row :to
      row :created_at
      row :from
      row :comment
    end
    columns do
      column do
        panel "Items" do
          table_for transfer.sorted_containers do
            column(:item_name) { |container| container.item.name }
            column(:quantity)
          end
        end
      end
      column do
        panel "By Category" do
          table_for transfer.quantities_by_category.to_a do
            column(:category) { |record| record.first }
            column(:quantity) { |record| record.last }
          end
        end
      end
    end
  end
end
