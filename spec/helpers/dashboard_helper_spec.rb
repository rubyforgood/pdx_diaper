require "rails_helper"

RSpec.describe DashboardHelper, type: :helper do
	it "returns array of 1 donation" do
		d = FactoryGirl.create(:donation, source: "Diaper Drive")
		result = diaper_drives_total()
		expect(result).to eq([d])
	end
	context "when donation is out of date range" do
		it "returns array of 0 donations" do
			d = FactoryGirl.create(:donation, source: "Diaper Drive")
			result = diaper_drives_total(Date.today - 1.year, Date.today - 10.days)
			expect(result).to eq([])
		end
	end

	it "returns a count of 10" do
		d = FactoryGirl.create(:donation, source: "Diaper Drive")
		c = FactoryGirl.create(:container, quantity: 10)
		d.containers << c
		d.save
		result = diaper_totals_by_source("Diaper Drive")
		expect(result).to eq(10)
	end

	it "returns a hash with diaper total for source: Diaper Drive" do
		d = FactoryGirl.create(:donation, source: "Diaper Drive")
		c = FactoryGirl.create(:container, quantity: 10)
		d.containers << c
		d.save
		result = diaper_totals()
		expect(result["Diaper Drive"]).to be >= 10
	end

	it "returns a hash with diaper total for source: Purchased Supplies" do
		d = FactoryGirl.create(:donation, source: "Purchased Supplies")
		c = FactoryGirl.create(:container, quantity: 1)
		d.containers << c
		d.save
		result = diaper_totals()
		expect(result["Purchased Supplies"]).to eq 1
	end

	it "returns a count of 12" do
		l = FactoryGirl.create(:dropoff_location, name: "the bathroom")
		d = FactoryGirl.create(:donation, dropoff_location: l)
		c = FactoryGirl.create(:container, quantity: 12)
		d.containers << c
		d.save
		result = dropoff_totals_by_location("the bathroom")
		expect(result).to eq 12
	end

	it "returns a hash with a diaper total for Thomas's backpack" do
		l = FactoryGirl.create(:dropoff_location, name: "Thomas's backpack")
		d = FactoryGirl.create(:donation, dropoff_location: l)
		c = FactoryGirl.create(:container, quantity: 2)
		d.containers << c
		d.save
		result = dropoff_totals()
		expect(result["Thomas's backpack"]).to eq 2 
	end
	describe ".dropoff_totals_for_locations" do
		it "returns a hash" do
			result = dropoff_totals_for_locations
			expect(result).to be_a Hash
		end
		it "returns a hash with totals for locations" do
			l = FactoryGirl.create(:dropoff_location, name: "Thomas's house")
			d = FactoryGirl.create(:donation, dropoff_location: l)
			c = FactoryGirl.create(:container, quantity: 100)
			d.containers << c
			d.save
			result = dropoff_totals_for_locations
			expect(result["Thomas's house"]).to eq 100
		end
	end
	describe ".item_totals_for_inventories" do
		it "returns an array of hashes" do
			result = item_totals_for_inventories
			expect(result).to be_a Array
			expect(result.first).to be_a Hash
		end
		it "includes hashes with Inventory name" do
			i = FactoryGirl.create(:inventory, name: "Thomas's inventory")
			result = item_totals_for_inventories
			expect(result.last[:name]).to eq("Thomas's inventory")
		end
		it "includes data hash for inventory" do
			i = FactoryGirl.create(:inventory, name: "Thomas's inventory")
			d = FactoryGirl.create(:donation)
			c = FactoryGirl.create(:container, quantity: 100)
			d.containers << c
			d.save
			i.intake!(d)
			result = item_totals_for_inventories
			expect(result.last[:data]).to eq({c.item.name => 100})
		end
		it "includes data hash including all items in inventory" do
			i = FactoryGirl.create(:inventory, name: "Thomas's inventory")
			d = FactoryGirl.create(:donation)
			c = FactoryGirl.create(:container, quantity: 100)
			c2 = FactoryGirl.create(:container, quantity: 200)
			d.containers << c
			d.containers << c2
			d.save
			i.intake!(d)
			result = item_totals_for_inventories
			expect(result.last[:data]).to eq({c.item.name => 100, c2.item.name => 200})
		end
	end
end
