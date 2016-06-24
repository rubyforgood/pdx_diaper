require "rails_helper"

RSpec.describe DateRangeHelper, type: :helper do
	describe "split_range_into_dates" do
		context "when range is less than 21" do
			it "returns array w/ sequence of dates" do
				start_date = Date.parse("2016-06-1")
				end_date = Date.parse("2016-06-7")
				result = split_range_into_dates(start_date, end_date)
				expect(result).to eq([
					Date.parse("2016-06-1"),
					Date.parse("2016-06-2"),
					Date.parse("2016-06-3"),
					Date.parse("2016-06-4"),
					Date.parse("2016-06-5"),
					Date.parse("2016-06-6"),
					Date.parse("2016-06-7")
				])
			end
			it "returns array w/ longer sequence of dates" do
				start_date = Date.parse("2016-06-1")
				end_date = Date.parse("2016-06-20")
				result = split_range_into_dates(start_date, end_date)
				expected = []
				20.times do |x|
					expected << Date.parse("2016-06-#{x+1}")
				end
				expect(result).to eq(expected)
			end
		end
		context "when range == 21" do
			it "returns array with Sunday dates for range" do
				start_date = Date.parse("2016-06-1")
				end_date = Date.parse("2016-06-21")
				result = split_range_into_dates(start_date, end_date)
				expect(result).to eq([
					Date.parse("2016-06-5"),
					Date.parse("2016-06-12"),
					Date.parse("2016-06-19"),
					Date.parse("2016-06-21")
				])
			end
		end
		context "when range > 21" do
			it "returns array with Sunday dates for range" do
				start_date = Date.parse("2016-06-1")
				end_date = Date.parse("2016-06-30")
				result = split_range_into_dates(start_date, end_date)
				expect(result).to eq([
					Date.parse("2016-06-5"),
					Date.parse("2016-06-12"),
					Date.parse("2016-06-19"),
					Date.parse("2016-06-26"),
					Date.parse("2016-06-30")
				])
			end
		end
		context "when range is greater than 62" do
			it "returns array with dates at the beginning of each month" do
				start_date = Date.parse("2016-05-1")
				end_date = Date.parse("2016-07-1")
				result = split_range_into_dates(start_date, end_date)
				expect(result).to eq([
					Date.parse("2016-05-1"),
					Date.parse("2016-06-1"),
					Date.parse("2016-07-1")
				])
			end
		end
	end
end
