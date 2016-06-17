require "rails_helper"

RSpec.describe Ticket, type: :model do
  it "has a date" do
    ticket = Ticket.create
    expect(ticket.created_at).to_not be nil
  end

  it "has an id" do
    ticket = Ticket.create(id: 5)
    expect(ticket.id).to_not be nil
  end

end