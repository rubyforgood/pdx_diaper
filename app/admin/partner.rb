# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#
# (manually added 18 June 2016)

ActiveAdmin.register Partner do

  menu parent: "Address Book", priority: 11, label: "Partner Organizations"

  permit_params :name, :email

  index do
  	selectable_column
  	column :name, sortable: :name
  	column :email, sortable: :email
  	actions
  end

end
