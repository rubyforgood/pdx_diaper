module DashboardHelper

  def diaper_totals_by_source(start_date=send(:default_start_date), end_date=send(:default_end_date))
    Donation.joins(:containers)
      .includes(:containers)
      .between(start_date, end_date)
      .group(:source)
      .sum("containers.quantity")
  end

  def dropoff_totals(start_date=send(:default_start_date), end_date=send(:default_end_date))
    Donation.joins(:dropoff_location, :containers)
      .includes(:dropoff_location, :containers)
      .between(start_date, end_date)
      .group("dropoff_locations.name")
      .sum("containers.quantity")
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

	def ticket_totals_by_inventory(start_date=send(:default_start_date), end_date=send(:default_end_date))
		Ticket.joins(:containers)
			.includes(:containers)
			.where(created_at: start_date..end_date)
			.group(:inventory_id)
			.sum(:quantity)
	end

	def ticket_totals_by_partner(start_date=send(:default_start_date), end_date=send(:default_end_date))
		Ticket.joins(:containers)
			.includes(:containers)
			.where(created_at: start_date..end_date)
			.group(:partner_id)
			.sum(:quantity)
	end

	def container_quantity_by_type(type, start_date=send(:default_start_date), end_date=send(:default_end_date))
		Container.where(itemizable_type: type)
			.where(created_at: start_date..end_date)
			.sum(:quantity)
	end

	def default_start_date
		DateTime.now - 1.year
	end

	def default_end_date
		DateTime.now
	end

end
