sports = Category.find_or_create_by!(name:"sports")
festivals = Category.find_or_create_by!(name:"festivals")
concerts = Category.find_or_create_by!(name:"concerts")
popups = Category.find_or_create_by!(name:"popups")
comedy = Category.find_or_create_by!(name:"comedy")
conventions = Category.find_or_create_by!(name:"conventions")

@venues = []
100. times do
  venue_names = ["Arena", "Stadium", "Center", "Theatre", "Palace", "Center for Children Who Can't Read Good"]

  name = Faker::StarWars.character
  city = Faker::Address.city
  state = Faker::Address.state

  @venues << Venue.find_or_create_by!(
              name: "#{name} #{venue_names.sample}",
              city: city,
              state: state)
end

@event_times = []
365.times do
  @event_times << Faker::Time.between(DateTime.now, DateTime.now + 365)
end

6.times do
  festivals.events.create(
    name: "Yazz Festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/Beaches-Jazz-Festival-Toronto.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Bumba-meu-boi Festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/Bumba-meu-boi+Festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Festival of Lights",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/Lyon+light+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Marinduque festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/MARINDUQUE_dazzles+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Festival of Marinduque",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/MARINDUQUE_festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Nilayagan Festivaol of Prosperidad",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/NILAYAGAN+FESTIVAL+OF+PROSPERIDAD.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Beer Fest!!!",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/beer+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Festival of People in Bubbles",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/bubble+boy+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Computer Music Festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/computer+music.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Elephant Festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/elephant+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Fun Festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/fun+festival.jpg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Moon Festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/moon+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
  festivals.events.create(
    name: "Sunset Festival",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/festival/sunset+festival.jpg"),
    time: @event_times.sample,
    status: "active")
end

6.times do
concerts.events.create(
  name: "The Beetles",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/beetles+concert.jpeg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Queen B",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/beyonce+concery.jpeg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Chris Brown",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/chris+brown+concert.jpeg"),
  time: @event_times.sample)
concerts.events.create(
  name: "David Bowie",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/davidbowie+concert.jpg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Drizzy Drake",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/drake+concert.jpeg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Hova",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/jay+z+concert.jpeg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Kpop Boyzzzz",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/kpop+boyz.jpg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Gaga Ooo Lala",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/lady+gaga+concert.jpeg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Muppet Rock",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/muppets+rocking.jpg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Sir Paul McCartney",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/paul+mccartney+concert.jpg"),
  time: @event_times.sample)
concerts.events.create(
  name: "Vanessa Carlton",
  venue_id: @venues.sample.id,
  image: open("https://s3.amazonaws.com/ticket-cacher/categories/concerts/vanessa-carlton_concert.jpg"),
  time: @event_times.sample)
end

6.times do
  sports.events.create(
    name: "USA Basketball",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/Olympic+Basketball.jpg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Shuttlecock",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/badminton+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Ball and Foot",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+ball+and+foot+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Ball",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+ball.jpg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Bow",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+bow+and+arrow+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Stick and Puck",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/game+with+stick+and+puck+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Heat at Clippers",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/heat+at+clippers+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Basketball Gurlz",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/olympic_basketball.jpg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Surfs up Brehhhhhh",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/surf+competetion+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
  sports.events.create(
    name: "Game with Racket",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/sports/serena+williams+match+sports.jpeg"),
    time: @event_times.sample,
    status: "active")
end

6.times do
  popups.events.create(
    name: "Arugla Time",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/arugula+time.jpg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "All Things Avacado",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/avacado.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Benedicts fa Dayzzz",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/benedicts+fa+days.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Fancy Stuff with Eggs",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/egg+things.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "All of the plates of all of the food",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/food+plates.jpg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Veggie Means Healthy",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/green_beans_and_carrots.jpg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Sandwiches and stoof",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/sandwich+pop+up.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Waffle time!",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/waffle+pop+up.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "Watawatamelonnnnn",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/watawatamelonnnnn.jpeg"),
    time: @event_times.sample,
    status: "active")
  popups.events.create(
    name: "I'm on a river boat, take a look at me!",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/pop-ups/river+boat+festival.jpeg"),
    time: @event_times.sample,
    status: "active")
end

9.times do
  comedy.events.create(
    name: "Louis C.K.",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/louis_ck.jpg"),
    time: @event_times.sample,
    status: "active")
end

9.times do
  conventions.events.create(
    name: "Cosplay Extravaganza",
    venue_id: @venues.sample.id,
    image: open("https://s3.amazonaws.com/ticket-cacher/categories/comicon.jpg"),
    time: @event_times.sample,
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
  fullname: "admin",
  email: "admin@ticketcacher.com",
  password: "password",
  role: 1)
