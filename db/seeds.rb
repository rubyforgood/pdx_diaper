# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end unless Rails.env.production?

# Creates Seed Data for the organization
DropoffLocation.find_or_create_by!(name: "Know Thy Food & Warehouse Cafe") do |location|
  location.address = "3434 SE Milwaukie Ave., Portland, OR 97202"
end
DropoffLocation.find_or_create_by!(name: "Tidee Didee Diaper Service") do |location|
  location.address = "6011 SE 92nd Ave., Portland,OR 97266"
end
DropoffLocation.find_or_create_by!(name: "Southside Swap & Play") do |location|
  location.address = "5239 SE Woodstock Ave, Portland, OR 97206"
end
DropoffLocation.find_or_create_by!(name: "Kuts 4 Kids & Adults") do |location|
  location.address = "4423 SE Hawthorne Blvd., Portland, OR 97215"
end
DropoffLocation.find_or_create_by!(name: "JJ Jump") do |location|
  location.address = "9057 SE Jannsen Rd., Clackamas, OR 97015"
end

Partner.find_or_create_by!(name: "Teen Parent Services - PPS")
Partner.find_or_create_by!(name: "Portland Homeless Family Solutions")
Partner.find_or_create_by!(name: "Pregnancy Resource Center")
Partner.find_or_create_by!(name: "Rose Haven")
Partner.find_or_create_by!(name: "Volunteers of America")
Partner.find_or_create_by!(name: "Clackamas Service Center")
Partner.find_or_create_by!(name: "Housing Alternatives")
Partner.find_or_create_by!(name: "JOIN")
Partner.find_or_create_by!(name: "Emmanuel Housing Center")
Partner.find_or_create_by!(name: "Catholic Charities")
Partner.find_or_create_by!(name: "Healthy Families of Oregon")
Partner.find_or_create_by!(name: "NARA Northwest")
Partner.find_or_create_by!(name: "Job Corps")
Partner.find_or_create_by!(name: "Helensview Middle and High School")

Inventory.find_or_create_by!(name: "Bulk Storage (Arborscape)") do |inventory|
  inventory.address = "Unknown"
end
Inventory.find_or_create_by!(name: "Diaper Storage Unit") do |inventory|
  inventory.address = "Unknown"
end
Inventory.find_or_create_by!(name: "PDX Diaper Bank (Office)") do |inventory|
  inventory.address = "Unknown"
end

items_by_category = {
  "Diapers - Adult Briefs" => [
    { name: "Adult Briefs (Large/X-Large)" },
    { name: "Adult Briefs (Medium/Large)" },
    { name: "Adult Briefs (Small/Medium)" },
    { name: "Adult Briefs (XXL)" }
  ],
  "Diapers - Childrens" => [
    { name: "Cloth Diapers (Plastic Cover Pants)" },
    { name: "Disposable Inserts" },
    { name: "Kids (Newborn)" },
    { name: "Kids (Preemie)" },
    { name: "Kids (Size 1)" },
    { name: "Kids (Size 2)" },
    { name: "Kids (Size 3)" },
    { name: "Kids (Size 4)" },
    { name: "Kids (Size 5)" },
    { name: "Kids (Size 6)" },
    { name: "Kids L/XL (60-125 lbs)" },
    { name: "Kids Pull-Ups (2T-3T)" },
    { name: "Kids Pull-Ups (3T-4T)" },
    { name: "Kids Pull-Ups (4T-5T)" },
    { name: "Kids S/M (38-65 lbs)" },
    { name: "Swimmers" },
  ],
  "Diapers - Cloth (Adult)" => [
    { name: "Adult Cloth Diapers (Large/XL/XXL)" },
    { name: "Adult Cloth Diapers (Small/Medium)" },
  ],
  "Diapers - Cloth (Kids)" => [
    { name: "Cloth Diapers (AIO's/Pocket)" },
    { name: "Cloth Diapers (Covers)" },
    { name: "Cloth Diapers (Prefolds & Fitted)" },
    { name: "Cloth Inserts (For Cloth Diapers)" },
    { name: "Cloth Swimmers (Kids)" },
  ],
  "Incontinence Pads - Adult" => [
    { name: "Adult Incontinence Pads" },
    { name: "Underpads (Pack)" },
  ],
  "Misc Supplies" => [
    { name: "Bed Pads (Cloth)" },
    { name: "Bed Pads (Disposable)" },
    { name: "Bibs (Adult & Child)" },
    { name: "Diaper Rash Cream/Powder" },
  ],
  "Training Pants" => [
    { name: "Cloth Potty Training Pants/Underwear" },
  ],
  "Wipes - Childrens" => [
    { name: "Wipes (Baby)" },
  ]
}

items_by_category.each do |category, entries|
  entries.each do |entry|
    record = Item.find_or_create_by!(name: entry[:name]) do |item|
      item.attributes = entry.except(:name)
    end
  end
end

Item.find_or_create_by!(name: "Adult Briefs (Large/X-Large)") do |item|
  item.category = "Diapers - Adult Briefs"
end
Item.find_or_create_by!(name: "Adult Briefs (Medium/Large)") do |item|
  item.category = "Diapers - Adult Briefs"
end
Item.find_or_create_by!(name: "Adult Briefs (Small/Medium)") do |item|
  item.category = "Diapers - Adult Briefs"
end
Item.find_or_create_by!(name: "Adult Briefs (XXL)") do |item|
  item.category = "Diapers - Adult Briefs"
end
Item.find_or_create_by!(name: "Adult Cloth Diapers (Large/XL/XXL)") do |item|
  item.category = "Diapers - Cloth (Adult)"
end
Item.find_or_create_by!(name: "Adult Cloth Diapers (Small/Medium)") do |item|
  item.category = "Diapers - Cloth (Adult)"
end
Item.find_or_create_by!(name: "Adult Incontinence Pads") do |item|
  item.category = "Incontinence Pads - Adult"
end
Item.find_or_create_by!(name: "Bed Pads (Cloth)") do |item|
  item.category = "Misc Supplies"
end
Item.find_or_create_by!(name: "Bed Pads (Disposable)") do |item|
  item.category = "Misc Supplies"
end
Item.find_or_create_by!(name: "Bibs (Adult & Child)") do |item|
  item.category = "Misc Supplies"
end
Item.find_or_create_by!(name: "Cloth Diapers (AIO's/Pocket)") do |item|
  item.category = "Diapers - Cloth (Kids)"
end
Item.find_or_create_by!(name: "Cloth Diapers (Covers)") do |item|
  item.category = "Diapers - Cloth (Kids)"
end
Item.find_or_create_by!(name: "Cloth Diapers (Plastic Cover Pants)") do |item|
  item.category = "Diapers - Childrens"
end
Item.find_or_create_by!(name: "Cloth Diapers (Prefolds & Fitted)") do |item|
  item.category = "Diapers - Cloth (Kids)"
end
Item.find_or_create_by!(name: "Cloth Inserts (For Cloth Diapers)") do |item|
  item.category = "Diapers - Cloth (Kids)"
end
Item.find_or_create_by!(name: "Cloth Potty Training Pants/Underwear") do |item|
  item.category = "Training Pants"
end
Item.find_or_create_by!(name: "Cloth Swimmers (Kids)") do |item|
  item.category = "Diapers - Cloth (Kids)"
end
Item.find_or_create_by!(name: "Diaper Rash Cream/Powder") do |item|
  item.category = "Misc Supplies"
end
Item.find_or_create_by!(name: "Disposable Inserts") do |item|
  item.category = "Diapers - Childrens"
end
Item.find_or_create_by!(name: "Kids (Newborn)") do |item|
  item.category = "Diapers - Childrens"
end
