feature "viewing an inventory" do
  	it "it shows all the inventory locations" do
  		i = create(:inventory, with_items: 5)
  		visit "/inventories/#{i.id}"
  		expect(page).to have_content("Create a Distribution Ticket")
  		within "#items" do
  			expect(page).to have_xpath("//tr", count: 6) # header row + 5 data rows
  		end
  	end
end