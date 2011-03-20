# tripit

A very high-level abstraction library providing objects to interact with the TripIt API. It is essentially a multi-user wrapper with each object being bound to a client. This library's methodology of dealing with API data was heavily influenced by [Mike Richards' Dopplr gem](http://github.com/mikeric/dopplr).

Every object in this library mirrors the official TripIt API's properties as closely as possible. Each TripIt API object and its properties have been converted into a Ruby object. To get a list of all the objects and their properties, please see the [TripIt API XML Schema](https://api.dev.tripit.com/xsd/tripit-api-obj-v1.xsd) and the List of usable Objects below. You can also read the [TripIt API Documentation](http://github.com/tripit/api/downloads) for further details.

## Install

    gem install tripit

## Usage

Here are some examples of how to use a few of the objects available. 

### TripIt::OAuth

Create a **TripIt::OAuth** instance with your consumer token and secret. Authorize the client using your access token, provided that you've already obtained one.

    client = TripIt::OAuth.new('1a2b3c4d5e', '2a3b4c5d6e')
    client.authorize_from_access('3a4b5c6d7e', '4a5b6c7d8e')
    
### TripIt::Profile

**TripIt::Profile** is used for viewing and creating objects related to the TripIt user you authenticated with **TripIt::OAuth**.

	client = TripIt::OAuth.new('1a2b3c4d5e', '2a3b4c5d6e')
	client.authorize_from_access('3a4b5c6d7e', '4a5b6c7d8e')

	# Instantiate the user by loading his profile -- pass the client object so Profile knows how to authenticate.
	myuser = TripIt::Profile.new(client)
	
	# Get the user's public display name
	myuser.public_display_name => "Test User"
	
	# Get the user's screen name
	myuser.screen_name => "test_user"
	
	# Get a list of the user's registered e-mail addresses 
	# (returns Array of TripIt::ProfileEmailAddress objects)
	myuser.profile_email_addresses => [TripIt::ProfileEmailAddress]
	
	# Get a list of the user's trips 
	# (returns Array of TripIt::Trip objects. As you use them, they will lazy-load their children.)
	myuser.trips => [TripIt::Trip]
	
	# Get a list of the user's trips, and populate all child objects in one call 
	# (returns Array of populated TripIt::Trip objects)
	myuser.trips(:include_objects => true) => [TripIt::Trip]
	
	# Check if the user is a TripIt Pro user, and then get an 
	# array of his registered TripIt::PointsProgram objects
	if myuser.is_pro?
		myuser.points_programs => [TripIt::PointsProgram]
	end

### TripIt::Trip

**TripIt::Trip** is used for viewing and creating objects related to a Trip. As previously, you must be authenticated with **TripIt::OAuth**.

	client = TripIt::OAuth.new('1a2b3c4d5e', '2a3b4c5d6e')
	client.authorize_from_access('3a4b5c6d7e', '4a5b6c7d8e')
	
	# Load a known Trip ID. If you don't know this, and are looking 
	# for a user's trips, see TripIt::Profile.trips
	trip_id = 12345678
	mytrip = TripIt::Trip.new(client, trip_id)
	
	# Get the Trip's primary location
	mytrip.primary_location => "Happy, Texas"
	
	# Get a list of nearby users (returns Array of TripIt::Profile objects)
	mytrip.closeness_matches => [TripIt::Profile]
	
	# Get the screen name of the first closeness match
	mytrip.closeness_matches.first.screen_name => "traveling_friend"
	
	# Get a list of the AirObjects for this trip 
	# (returns Array of TripIt::AirObject objects)
	mytrip.air => [TripIt::AirObject]
	
	# Get a list of segments for the trip's first TripIt::AirObject
	# (returns Array of TripIt::AirSegment objects)
	mytrip.air.first.segment => [TripIt::AirSegment]
	
	# Get some segment information for the first segment
	nyclhr = mytrip.air.first.segment.first
	nyclhr.start_city_name => "New York, NY"
	nyclhr.end_city_name => "London, United Kingdom"
	nyclhr.marketing_airline => "British Airways"

	# Get a list of Hotels for this Trip 
	# (returns Array of TripIt::LodgingObject objects)
	mytrip.lodging => [TripIt::LodgingObject]
	
	# Get some info on the first hotel stay of this trip
	hot = mytrip.lodging.first
	hot.supplier_name => "Westin Times Square"
	hot.room_type => "Presidential Suite"
	
	# DateTime properties always return native Ruby DateTime objects
	hot.start_date_time => 2011-03-01T11:37:00+00:00
	
	# Address properties always return TripIt::Address objects
	hot.address => TripIt::Address
	hot.address.city => "New York"
	
## List of usable Objects

*	TripIt::Address
*	TripIt::FlightStatus
*	TripIt::Group
*	TripIt::Image
*	TripIt::Invitee
*	TripIt::PointsProgram
*	TripIt::PointsProgramActivity
*	TripIt::PointsProgramExpiration
*	TripIt::Profile
*	TripIt::ProfileEmailAddress
*	TripIt::Traveler
*	TripIt::Trip
*	TripIt::TripCrsRemark

*	TripIt::ActivityObject
*	TripIt::AirObject
	*	TripIt::AirSegment
*	TripIt::CarObject
*	TripIt::CruiseObject
	*	TripIt::CruiseSegment
*	TripIt::DirectionsObject
*	TripIt::LodgingObject
*	TripIt::MapObject
*	TripIt::NoteObject
*	TripIt::RailObject
	*	TripIt::RailSegment
*	TripIt::RestaurantObject
*	TripIt::TransportObject
	*	TripIt::TransportSegment
*	TripIt::WeatherObject

## Contributing to tripit
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Alex Kremer. See LICENSE.txt for further details.

