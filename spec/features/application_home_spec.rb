feature "The homepage dashboard" do
  	it "shows dashboard features" do
  		create(:inventory, with_items: 10)
  		visit '/'
  		expect(page).to have_content("Dashboard")
  		within("#inventory") do
          expect(page).to have_xpath("//tr", count: 11) # header row + 2 data rows
  		end
  		expect(page).to have_content "Intake"
  	end
end