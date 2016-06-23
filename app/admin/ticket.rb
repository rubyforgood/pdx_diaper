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

  filter :inventory
  filter :partner
  filter :items
  filter :created_at, as: :date_range

  permit_params :inventory_id,
    :partner_id,
    :containers_attributes => [:item_id, :quantity, :id, :_destroy]

  controller do
    def create
      @ticket = Ticket.new permitted_params[:ticket]
      inventory = @ticket.inventory
      begin
        inventory.distribute!(@ticket)
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
      input :partner_id, :label => 'Partner', :as => :select, :collection => Partner.all
      input :inventory, :label => 'Storage Facility', :as => :select, :collection => Inventory.all
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
      row :partner
      row :created_at
    end
    panel "Items" do
       ul do
        ticket.containers.each do |container|
          li [container.item.name, container.quantity].join ", "
        end
       end
    end
  end
end
