sports = Category.find_or_create_by!(name:"sports")
festivals = Category.find_or_create_by!(name:"festivals")
concerts = Category.find_or_create_by!(name:"concerts")
popups = Category.find_or_create_by!(name:"popups")
comedy = Category.find_or_create_by!(name:"comedy")
conventions = Category.find_or_create_by!(name:"conventions")

venue1 = Venue.find_or_create_by!(
  name: "Outside",
  city: "Lima",
  state: "Ohio")
venue2 = Venue.find_or_create_by!(
  name: "Stadium",
  city: "Atlanta",
  state: "Kansas")
venue3 = Venue.find_or_create_by!(
  name: "Convention Hall",
  city: "St. Louis",
  state: "Georgia")
venue4 = Venue.find_or_create_by!(
  name: "Sports Stadium",
  city: "New York",
  state: "Utah")
venue5 = Venue.find_or_create_by!(
  name: "Hipster Bathouse",
  city: "Horace's Lair",
  state: "Beard")

9.times do
  festivals.events.create(
    name: "Balloon Fun",
    venue_id: venue1.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/air_balloons.jpg"),
    time: "March 02, 2017 16:00",
    status: "active")
end

concerts.events.create(
  name: "Muppet Rock",
  venue_id: venue2.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/muppets_rocking.jpg"),
  time: "November 20, 2020 18:00", status: "active")

9.times do
  sports.events.create(
    name: "Basketball Gurlz",
    venue_id: venue4.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/olympic_basketball.jpg"),
    time: "July 10, 2016 19:00",
    status: "active")
end

9.times do
  popups.events.create(
    name: "Veggie Means Healthy",
    venue_id: venue5.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/green_beans_and_carrots.jpg"),
    time: "July 10, 2016 19:00",
    status: "active")
end

9.times do
  comedy.events.create(
    name: "Louis C.K.",
    venue_id: venue3.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/louis_ck.jpg"),
    time: "July 10, 2016 19:00",
    status: "active")
end

9.times do
  conventions.events.create(
    name: "Cosplay Extravaganza",
    venue_id: venue3.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/comicon.jpg"),
    time: "July 10, 2016 19:00",
    status: "active")
end

User.create(
  first_name: "Dave",
  last_name: "Whit",
  email: "mustachefodays@example.com",
  password: "password",
  role: 0,
  fullname: "Dave Whit")

User.create(
  first_name: "Whitney",
  last_name: "Whit",
  email: "whit@example.com",
  password: "password",
  role: 0,
  fullname: "Whitney Whit")

event = Event.find_by(name: "Muppet Rock")

listing1 = Listing.new(
             user_id: User.first.id,
             event_id: event.id)

listing2 = Listing.new(
             user_id: User.last.id,
             event_id: event.id)

listing1.tickets << Ticket.new(price: 800, seat: "10", row: "2")

listing1.tickets << Ticket.new(price: 800, seat: "11", row: "2")

listing2.tickets << Ticket.new(price: 1000, seat: "1", row: "1")
listing1.save
listing2.save

User.create(
  first_name: "Monica",
  last_name: "Whooo",
  email: "monica@example.com",
  password: "password",
  role: 0,
  fullname: "Monica Whooo",
  status: "suspended")

User.create(
  fullname: "admin",
  email: "admin@ticketcacher.com",
  password: "password",
  role: 1)
