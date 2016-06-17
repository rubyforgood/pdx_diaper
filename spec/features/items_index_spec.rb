feature "viewing all item types" do
  	it "shows all items" do
  		create(:item)
  		create(:item)
  		visit '/items/'
  		within("#items") do
          expect(page).to have_xpath("//tr", count: 3) # header row + 2 data rows
  		end
  	end
end