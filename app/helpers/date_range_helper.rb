module DateRangeHelper
	def split_range_into_dates(start_date, end_date)
		range = (start_date..end_date)
		if range.count < 21
			result = range.group_by(&:day).map { |_,v| v.first }
		elsif range.count >= 21 && range.count < 62
			result = range.select(&:sunday?)
		else
			result = range.group_by(&:month).map { |_,v| v.first.beginning_of_month }
			unless result[0] == start_date
				result[0] = start_date
			end
		end
		unless result[result.count-1] == end_date
			result << end_date
		end
		result
	end
end