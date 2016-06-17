feature "viewing all inventory locations" do
  	it "shows all inventories" do
  		create(:inventory)
  		create(:inventory)
  		visit '/inventories/'
  		within("#inventories") do
          expect(page).to have_xpath("//tr", count: 3) # header row + 2 data rows
  		end
  	end
end