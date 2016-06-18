# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Creates Seed Data for the organization
DropoffLocation.create!(name: "Know Thy Food & Warehouse Cafe", address: "3434 SE Milwaukie Ave.,
Portland, OR 97202")
DropoffLocation.create!(name: "Tidee Didee Diaper Service", address: "6011 SE 92nd Ave., Portland,OR 97266")
DropoffLocation.create!(name: "Southside Swap & Play", address: "5239 SE Woodstock Ave, Portland, OR 97206")
DropoffLocation.create!(name: "Kuts 4 Kids & Adults", address: "4423 SE Hawthorne Blvd., Portland, OR 97215")
DropoffLocation.create!(name: "JJ Jump", address: "9057 SE Jannsen Rd., Clackamas, OR 97015")

Partner.create!(name: "Teen Parent Services - PPS")
Partner.create!(name: "Portland Homeless Family Solutions")
Partner.create!(name: "Pregnancy Resource Center")
Partner.create!(name: "Rose Haven")
Partner.create!(name: "Volunteers of America")
Partner.create!(name: "Clackamas Service Center")
Partner.create!(name: "Housing Alternatives")
Partner.create!(name: "JOIN")
Partner.create!(name: "Emmanuel Housing Center")
Partner.create!(name: "Catholic Charities")
Partner.create!(name: "Healthy Families of Oregon")
Partner.create!(name: "NARA Northwest")
Partner.create!(name: "Job Corps")
Partner.create!(name: "Helensview Middle and High School")
