module DashboardHelper

	def diaper_drives_total(start_date=send(:default_start_date), end_date=send(:default_end_date))
		Donation.where(source: "Diaper Drive").where("created_at >= ? AND created_at <= ?", start_date, end_date)
	end

	# You can either provide an array or a string for "Source" and it will query more efficiently
	# if you provide an array. This reduces the n+1 problem that was happening with individual
	# source queries
	def diaper_totals_by_source(source, start_date=send(:default_start_date), end_date=send(:default_end_date))
		donations = Donation.includes(:containers).includes(:dropoff_location).where(source: source).where("created_at >= ? AND created_at <= ?", start_date, end_date)
		total = 0
		donations_at_source = {"Diaper Drive" => 0, "Purchased Supplies" => 0, "Donation Pickup Location" => 0}
		donations.each do |donation|
			donations_at_source[donation.source] ||= 0
            donations_at_source[donation.source] += donation.containers.collect { |c| c.quantity }.reduce(:+)
		end
		return donations_at_source[source] unless source.is_a?(Array)
		return donations_at_source
	end
	
	def diaper_totals(start_date=send(:default_start_date), end_date=send(:default_end_date))
		sources = {"Diaper Drive" => 0, "Purchased Supplies" => 0, "Donation Pickup Location" => 0}
		diaper_totals_by_source(sources.keys)
	end
	
	def dropoff_totals_by_location(locations, start_date=send(:default_start_date), end_date=send(:default_end_date))
		donations = Donation.includes(:dropoff_location).where(dropoff_location: locations).where("created_at >= ? AND created_at <= ?", start_date, end_date)
		donations_at_dropoff_location = {}
		donations.each do |donation|
			donations_at_dropoff_location[donation.dropoff_location.name] ||= 0
			donations_at_dropoff_location[donation.dropoff_location.name] += donation.containers.collect { |c| c.quantity }.reduce(:+)
		end
		return donations_at_dropoff_location[locations] unless locations.is_a?(Array)
		return donations_at_dropoff_location
	end

	def dropoff_totals_for_locations(start_date=send(:default_start_date), end_date=send(:default_end_date))
		locations = {}
		l = DropoffLocation.all.collect { |d| d.id }
		dropoff_totals_by_location(l, start_date, end_date)
		
	end

	def dropoff_totals(start_date=send(:default_start_date), end_date=send(:default_end_date))
		locations_list = DropoffLocation.all.collect { |d| d.id }
		dropoff_totals_by_location(locations_list, start_date, end_date)
	end

	# Returns an array of hashes for each inventory and the Items and
	# quantities that are currently stored at each. Used in bar chart.
	def item_totals_for_inventories
		result = []
		Inventory.includes(:items).all.each do |i|
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
