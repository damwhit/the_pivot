require 'rails_helper'


RSpec.describe "OrderMailer" do
  describe 'email' do
    before :each do
      @user = User.create(fullname: "Lucas Jones", password: "password", email: "lucas@email.com")

      seller = User.create(fullname: "Bob Poo", password: "password", email: "bob@email.com")

      venue = Venue.find_or_create_by!(name: "Neat Ampitheatre", city: "Des Moines", state: "Iowa")

      category = Category.create(name: "concerts")

      event = category.events.create!(
        name: "Sun Festival",
        venue_id: venue.id,
        time: "March 02, 2017 16:00",
        status: "active")

      ticket1 = Ticket.new(price: 800, seat: "80", row: "20")

      listing_1 = event.listings.new(user_id: seller.id)
      listing_1.tickets << ticket1
      listing_1.save

      @order = @user.orders.create(street: "1600 pennslyvania",
                                  city: "washington",
                                  state: "District of Columbia",
                                  zip: "46250",
                                  fullname: "Lucas Jones",
                                  first_name: "jonathon",
                                  last_name: "adams",
                                  email: @user.email)

      @order.tickets << ticket1

    end

    let(:mail) { OrderMailer.order_email(@order) }

    it 'renders the subject' do
      expect(mail.subject).to eql('🎉Here is your ticket receipt!🎉')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([@user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['no-reply@example.com'])
    end

    it 'assigns @order.fullname' do
      expect(mail.body.encoded).to match(@user.fullname)
    end
  end
end
