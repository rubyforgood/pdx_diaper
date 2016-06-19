require "rails_helper"

RSpec.describe "donation activeadmin", type: :controller do
  let (:donation){FactoryGirl.create :donation}
  xit "increases container count by 1" do
    admin=AdminUser.first
    sign_in(admin)
  end

  it "increases donations container count by 1" do

  end
end
