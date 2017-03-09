# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#
# (modified 18 June 2016)


ActiveAdmin.register Ticket do
  actions :all, except: [:edit, :update, :destroy]

  action_item :reclaim, only: :show do
    link_to "Reclaim", reclaim_ticket_path(ticket), method: :put
  end

  action_item :print, only: :show do
    link_to "Print", print_ticket_path(ticket, format: :pdf)
  end

  filter :inventory
  filter :partner
  filter :items
  filter :items, as: :select,
        collection: proc { Item.all.order(:name).map { |a| [a.name, a.id] } }
  filter :created_at, as: :date_range

  permit_params :inventory_id,
    :partner_id,
    :comment,
    :containers_attributes => [:item_id, :quantity, :id, :_destroy]

  controller do
    def create
      @ticket = Ticket.new permitted_params[:ticket]
      inventory = @ticket.inventory
      begin
        inventory.distribute!(@ticket) if inventory
        if @ticket.save
          redirect_to @ticket, notice: "Successfully created new ticket"
        else
          render :new, error: "There was an error creating the ticket"
        end
      rescue Errors::InsufficientAllotment => e
        items = ""
        e.insufficient_items.each do |insufficiency|
          container = @ticket.containers.find { |c| c.item_id == insufficiency[:item_id] }
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

  member_action :print do
    @filename = "pdx_ticket_#{resource.id}.pdf"
  end

  member_action :reclaim, method: :put do
    inventory = resource.inventory
    inventory.reclaim!(resource)
    redirect_to tickets_path, notice: "Inventory has been updated and the ticket is destroyed"
  end

  index do
    selectable_column
    column :id do |ticket|
      link_to ticket.id, ticket
    end
    column :partner
    column :inventory
    column :number_of_items do |ticket|
      ticket.containers.count
    end
    column :total_quantity
    column :created_at
    actions
  end

  form do |f|
    inputs do
      input :partner, :label => 'Partner', :as => :select, :collection => Partner.all
      input :inventory, :label => 'Storage Facility', :as => :select, :collection => Inventory.all
      input :comment, :label => 'Comments', :as => :string
    end
    inputs 'Items' do
      f.has_many :containers, allow_destroy: true do |container|
        container.input :item_id, :label => 'Items', :as => :select, :collection => Item.all.order(:name)
        container.input :quantity
      end
    end
    actions
  end

  show do |ticket|
    attributes_table do
      row :partner
      row :created_at
      row :inventory
      row :comment
    end
    columns do
      column do
        panel "Items" do
          table_for ticket.sorted_containers do
            column(:item_name) { |container| container.item.name }
            column(:quantity)
          end
        end
      end
      column do
        panel "By Category" do
          table_for ticket.quantities_by_category.to_a do
            column(:category) { |record| record.first }
            column(:quantity) { |record| record.last }
          end
        end
      end
    end
  end
end
