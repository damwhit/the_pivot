puts "Creating categories"
sports = Category.find_or_create_by!(name:"sports")
festivals = Category.find_or_create_by!(name:"festivals")
concerts = Category.find_or_create_by!(name:"concerts")
popups = Category.find_or_create_by!(name:"popups")
comedy = Category.find_or_create_by!(name:"comedy")
conventions = Category.find_or_create_by!(name:"conventions")

puts "Adding venues"
@venues = []

100.times do
  venue_names = ["Arena", "Stadium", "Center", "Theatre", "Palace", "Center for Children Who Can't Read Good"]

  name = Faker::StarWars.character
  city = Faker::Address.city
  state = Faker::Address.state

  @venues << Venue.find_or_create_by!(
              name: "#{name} #{venue_names.sample}",
              city: city,
              state: state)
end

puts "Hold on for those times"
@event_times = []

250.times do
  @event_times << Faker::Time.between(DateTime.now-60, DateTime.now + 365)
end
@event_times = @event_times.uniq

puts "MMMM tags"

50.times do
  name = Faker::Hipster.words(rand(1..3)).join(" ")
  Tag.create(name: name)
end

puts "Time for the festivities"
2.times do
  festivals.events.create(
    name: "Yazz Festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/Beaches-Jazz-Festival-Toronto.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Bumba-meu-boi Festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/Bumba-meu-boi+Festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Festival of Lights",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/Lyon+light+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Marinduque festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/MARINDUQUE_dazzles+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Festival of Marinduque",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/MARINDUQUE_festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Nilayagan Festivaol of Prosperidad",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/NILAYAGAN+FESTIVAL+OF+PROSPERIDAD.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Beer Fest!!!",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/beer+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Festival of People in Bubbles",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/bubble+boy+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Computer Music Festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/computer+music.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Elephant Festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/elephant+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Fun Festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/fun+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Moon Festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/moon+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Sunset Festival",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/festival/sunset+festival.jpg"),
    time: @event_times.sample,
    status: "active")
end

puts "Is live music more your deal?"
1.times do
  concerts.events.create(
    name: "The Beetles",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/beetles+concert.jpeg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Queen B",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/beyonce+concery.jpeg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Chris Brown",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/chris+brown+concert.jpeg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "David Bowie",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/davidbowie+concert.jpg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Drizzy Drake",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/drake+concert.jpeg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Hova",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/jay+z+concert.jpeg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Kpop Boyzzzz",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/kpop+boyz.jpg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Gaga Ooo Lala",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/lady+gaga+concert.jpeg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Muppet Rock",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/muppets+rocking.jpg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Sir Paul McCartney",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/concerts/paul+mccartney+concert.jpg"),
    time: @event_times.sample)
  concerts.events.create(
    name: "Vanessa Carlton",
    venue_id: @venues.sample.id,
    image: ("https://s3.amazonaws.com/ticket-cacher/categories/concerts/vanessa-carlton_concert.jpg"),
    time: @event_times.sample)
    puts "seeding concerts"
end
puts "Joust!"

1.times do
  sports.events.create(
    name: "USA Basketball",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/Olympic+Basketball.jpg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Shuttlecock",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/badminton+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Ball and Foot",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+ball+and+foot+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Ball",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+ball.jpg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Bow",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+bow+and+arrow+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Stick and Puck",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+stick+and+puck+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Heat at Clippers",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/heat+at+clippers+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Basketball Gurlz",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/olympic_basketball.jpg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Surfs up Brehhhhhh",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/surf+competetion+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Racket",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/sports/serena+williams+match+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
end
puts "Grow out those mustaches for charity"

1.times do
  popups.events.create(
    name: "Arugula Time",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/arugula+time.jpg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "All Things Avacado",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/avacado.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Benedicts fa Dayzzz",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/benedicts+fa+days.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Fancy Stuff with Eggs",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/egg+things.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "All of the plates of all of the food",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/food+plates.jpg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Veggie Means Healthy",
    venue_id: @venues.sample.id,
    image: ("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/green_beans_and_carrots.jpg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Sandwiches and stoof",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/sandwich+pop+up.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Waffle time!",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/waffle+pop+up.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Watawatamelonnnnn",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/watawatamelonnnnn.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "I'm on a river boat, take a look at me!",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/pop-ups/river+boat+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
    puts "seeding popups"
end
puts "HA!"

1.times do
  comedy.events.create(
    name: "Amy Schumer",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/comedy+amy+schumer.jpeg"),
    time: @event_times.sample,
    status: "active")
  comedy.events.create(
    name: "Jay Leno",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/comedy+leno.jpeg"),
    time: @event_times.sample,
    status: "active")
  comedy.events.create(
    name: "Robin Williams",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/comedy+robin+williams.jpeg"),
    time: @event_times.sample,
    status: "active")
  comedy.events.create(
    name: "Sarah Silverman",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/comedy+sarah+silverman.jpeg"),
    time: @event_times.sample,
    status: "active")
  comedy.events.create(
    name: "Tracy Morgan",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/comedy+tracy+morgan.jpg"),
    time: @event_times.sample,
    status: "active")
  comedy.events.create(
    name: "Zach Galifanakis",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/comedy+zach+galifanakis.jpeg"),
    time: @event_times.sample,
    status: "active")
  comedy.events.create(
    name: "Louis C.K.",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/louis+ck.jpg"),
    time: @event_times.sample,
    status: "active")
  comedy.events.create(
    name: "Sinbad... or good?",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/comedy/sinbad+comedy.jpeg"),
    time: @event_times.sample,
    status: "active")
end
puts "Dig out those costumes"

1.times do
  conventions.events.create(
    name: "Balloons arrr kewl",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/air+balloons.jpg"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Playing with fiyaaaa",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/atlanta+science+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Camel Convention",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/camel+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Cosplay Extravaganza",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/comicon.jpg"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Cooking Convention",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/cooking+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Dragon Convention",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/dragon+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Eyo Convention",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/eyo+festival+2.jpg"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Mountain Music Convention",
    venue_id: @venues.sample.id,
    image: ("http://s3.amazonaws.com/ticket-cacher/categories/conventions/mountain+sounds+festival.png"),
    time: @event_times.sample,
    status: "active")
  conventions.events.create(
    name: "Surfer Dude Convention",
    venue_id: @venues.sample.id,
    image: "http://s3.amazonaws.com/ticket-cacher/categories/conventions/surf+festival.jpeg",
    time: @event_times.sample,
    status: "active")
    puts "seeding conventions"
end

puts "TAG you're it!"
event_count = Event.count
@tags = Tag.all

rand(150..250).times do
  event = Event.find(rand(1..event_count))
  rand(0..5).times do
    event.tags << @tags.sample
  end
  event.save
end

venue_count = Venue.count
rand(50..100).times do
  venue = Venue.find(rand(1..venue_count))
  rand(0..5).times do
    venue.tags << @tags.sample
  end
  venue.save
end

puts "Almost there"

100.times do
  fullname = Faker::Name.name
  email = Faker::Internet.free_email(fullname.split[0])
  user = User.new(fullname: fullname, email: email, password: "password")

  if user.save
    date = Faker::Time.between(DateTime.now - 700, DateTime.now - 2)
    user.update(created_at: date, updated_at: date)

    5.times do
      user.listings.new(event_id: Event.order("RANDOM()").first.id)
    end

    user.listings.each do |listing|
      starting_seat = rand(1..25)
      rand(1..8).times do |n|
        listing.tickets << Ticket.new(price: 3000, row: 10.to_s, seat: (starting_seat + n).to_s)
      end
      listing.save
    end

    11.times do
      order = user.orders.new(street: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zip: Faker::Address.zip, fullname: fullname, email: email)

      if order.save
        order_date = Faker::Time.between(date, DateTime.now - 1)
        order.update(created_at: order_date, updated_at: order_date)
        order = Order.find(order.id)
        rand(1..7).times do
          order.tickets << Ticket.create(price: 3000, row: 7.to_s, seat: rand(1..10).to_s, listing_id: Listing.order("RANDOM()").first.id)
        end
        order.save
        statuses = ["paid","paid","paid","paid","paid","completed","completed","completed","completed","completed", "completed","completed","completed","completed","completed","cancelled"]
        order = Order.find(order.id)
        order.update(status: statuses.sample)
        order = Order.find(order.id)
        order.update(order_total: order.total)
      end
    end
  end
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

josh = User.create(
email: "josh@turing.io",
password: "password",
role: 0,
fullname: "Josh")

andrew = User.create(
email: "andrew@turing.io",
password: "password",
role: 0,
fullname: "Andrew")

event = Event.find_by(name: "Muppet Rock")

listing1 = Listing.new(
             user_id: josh.id,
             event_id: event.id)

listing2 = Listing.new(
             user_id: andrew.id,
             event_id: event.id)

listing1.tickets << Ticket.new(price: 800, seat: "10", row: "2")

listing1.tickets << Ticket.new(price: 800, seat: "11", row: "2")

listing2.tickets << Ticket.new(price: 1000, seat: "1", row: "1")
listing1.save
listing2.save

User.create(
  fullname: "admin",
  email: "admin@ticketcacher.com",
  password: "password",
  role: 1)

User.create(
  fullname: "jorge",
  email: "jorge@turing.io",
  password: "password",
  role: 1)
