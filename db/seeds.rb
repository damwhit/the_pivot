sports = Category.create(name:"sports")
festivals = Category.create(name:"festivals")
concerts = Category.create(name:"concerts")
popups = Category.create(name:"popups")
comedy = Category.create(name:"comedy")
conventions = Category.create(name:"conventions")

venue1 = Venue.find_or_create_by(name: "Outside", city: "Lima", state: "Ohio")
venue2 = Venue.find_or_create_by(name: "Stadium", city: "Hotdog", state: "Kansas")
venue3 = Venue.find_or_create_by(name: "Convention Hall", city: "Lil Boo", state: "Georgia")
venue4 = Venue.find_or_create_by(name: "Sports Stadium", city: "Big City", state: "Utah")
venue5 = Venue.find_or_create_by(name: "Hipster Bathouse", city: "Horace's Lair", state: "Beard")

9.times do
  festivals.events.create(name: "Balloon Fun", venue_id: venue1.id, time: "March 02, 2017 16:00", status: "active")
end

9.times do
  concerts.events.create(name: "Muppet Rock", venue_id: venue2.id, time: "November 20, 2020 18:00", status: "active")
end

9.times do
  sports.events.create(name: "Basketball Gurlz", venue_id: venue4.id, time: "July 10, 2016 19:00", status: "active")
end

9.times do
  popups.events.create(name: "Veggie Means Healthy", venue_id: venue5.id, time: "July 10, 2016 19:00", status: "active")
end

9.times do
  comedy.events.create(name: "Funny Guy", venue_id: venue3.id, time: "July 10, 2016 19:00", status: "active")
end

9.times do
  conventions.events.create(name: "Cosplay Extravaganza", venue_id: venue3.id, time: "July 10, 2016 19:00", status: "active")
end

admin = User.new(fullname: "admin", email: "admin@littleowl.com", password: "password", role: 1)

admin.save
