require "rails_helper"

RSpec.describe DonationsController, type: :controller do
  before(:each) { @admin_user = create(:admin_user); sign_in(@admin_user);
                 }
  let (:donation){ create :donation }

  it "increases container count by 1" do
  end

  it "increases donations container count by 1" do

  end
end
