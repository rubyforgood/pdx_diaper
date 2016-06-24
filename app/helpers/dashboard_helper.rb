module DashboardHelper

	def diaper_drives_total(start_date=default_start_date, end_date=default_end_date)
		Donation.where(source: "Diaper Drive").where("created_at >= ? AND created_at <= ?", start_date, end_date)
	end
	
	def diaper_totals_by_source(source, start_date=default_start_date, end_date=default_end_date)
		donations = Donation.where(source: source).where("created_at >= ? AND created_at <= ?", start_date, end_date)
		total = 0
		donations.each do |donation|
			donation.containers.each { |c| total += c.quantity }
		end
		total
	end
	
	def diaper_totals(start_date=default_start_date, end_date=default_end_date)
		sources = {"Diaper Drive" => 0, "Purchased Supplies" => 0, "Donation Pickup Location" => 0}
		sources.each do |key, value|
			sources[key] = diaper_totals_by_source(key, start_date, end_date)
		end
		sources
	end
	
	def dropoff_totals_by_location(location, start_date=default_start_date, end_date=default_end_date)
		l = DropoffLocation.find_by(name: location)
		donations = Donation.where(dropoff_location: l).where("created_at >= ? AND created_at <= ?", start_date, end_date)
		total = 0
		donations.each do |donation|
			donation.containers.each { |c| total += c.quantity }
		end
		total
	end

	def dropoff_totals_for_locations(start_date=default_start_date, end_date=default_end_date)
		locations = {}
		DropoffLocation.all.each do |loc|
			locations[loc.name] = dropoff_totals_by_location(loc.name, start_date, end_date)
		end
		locations
	end
	
	def dropoff_totals(start_date=default_start_date, end_date=default_end_date)
		locations_list = DropoffLocation.all
		locations = locations_list.map { |u| [u.name, 0] }.to_h
		locations.each do |key, value|
			locations[key] = dropoff_totals_by_location(key, start_date, end_date)
		end
	end

	# Returns an array of hashes for each inventory and the Items and
	# quantities that are currently stored at each. Used in bar chart.
	def item_totals_for_inventories
		result = []
		Inventory.all.each do |i|
			entry = { :name => i.name, :data => { } }
			i.holdings.each { |h| entry[:data] = entry[:data].merge({ h.item.name => h.quantity }) }
			result << entry
		end
		result
	end

	def default_start_date
		DateTime.now - 1.year
	end

	def default_end_date
		DateTime.now
	end

end