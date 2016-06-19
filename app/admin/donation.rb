# == Schema Information
#
# Table name: donations
#
#  id                  :integer          not null, primary key
#  source              :string
#  completed           :boolean          default(FALSE)
#  dropoff_location_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#
# modified 18 june 2016

ActiveAdmin.register Donation do

  permit_params :source, :dropoff_location_id, :inventory_id, :containers_attributes => [:item_id, :quantity, :id, :_destroy]

  member_action :add_item, method: :post do
    donation=Donation.find(params[:id])
    item=Item.find(params[:container][:item_id])
    donation.track(item,params[:container][:quantity].to_i)
    redirect_to donation_path(params[:id])
  end

  member_action :complete, method: :put do
    donation = Donation.find(params[:id])
    donation.complete
    redirect_to donation_path(params[:id])
  end

  member_action :destroy_item, method: :put do
    container = Container.find(params[:container_id]).delete
    redirect_to donation_path(params[:donation_id])
  end


action_item only: :show do
  if donation.completed == false
    link_to "Complete donation", complete_donation_path(donation.id), method: :put
  end
end

sources = ["Diaper Drive", "Purchased Supplies", "Donation Pickup Location"]

form do |f|
	inputs 'Create New Donation' do
    input :dropoff_location_id, :label => 'Dropoff Location', :as => :select, :collection => DropoffLocation.all
    input :source, :label => 'Source', :as => :select, :collection => sources
    input :inventory_id, :label => 'Storage Location', :as => :select, :collection => Inventory.all
  	actions
  end
end

index do
  selectable_column
  column "Receipt Number", :id
  column :source
  column :updated_at
  column :created_at
  actions
end

  show do
    attributes_table do
      row('Receipt Number'){ |d| d.id }
      row :source
      row :dropoff_location
      row "Storage Location" do
        resource.inventory.name
      end
      row :completed
      row :created_at
      row :updated_at
      row "Items" do |donation|
        if donation.containers.count > 0
          table_for resource.containers do
              column :quantity
              column :item
              column(:delete) { |container| link_to "Delete", destroy_item_donation_path(container_id: container.id, donation_id: resource.id), method: :put }
          end
        end
        nil
      end
    end
    unless donation.completed == true
      panel "Add Item" do
        form_for :container, { :url => add_item_donation_path } do |f|
          div do
            f.label :quantity
            f.text_field :quantity
          end
          div do
            f.label :item
            f.select("item_id", Item.all.collect { |i| [i.name, i.id] } )
          end
            f.submit
          end
        end
      end
    end
end

