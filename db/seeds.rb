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

9.times do
  concerts.events.create(
    name: "Muppet Rock",
    venue_id: venue2.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/muppets_rocking.jpg"),
    time: "November 20, 2020 18:00", status: "active")
end

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

admin = User.new(
  fullname: "admin",
  email: "admin@littleowl.com",
  password: "password",
  role: 1)

admin.save
