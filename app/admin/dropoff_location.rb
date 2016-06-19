# == Schema Information
#
# Table name: dropoff_locations
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  created_at :datetime
#  updated_at :datetime
#
# (modified 18 June 2016)

ActiveAdmin.register DropoffLocation do

  menu parent: "Address Book", label: "Drop-off Locations"

  permit_params :name, :address

  index do
  	selectable_column
  	column :name, sortable: :name
  	column :address, sortable: :address
  	actions
  end

end
