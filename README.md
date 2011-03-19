# tripit

An abstraction library providing objects to interact with the TripIt API. It is essentially a multi-user wrapper with each object being bound to a client. This library's methodology of dealing with API data was heavily influenced by [Mike Richards' Dopplr gem](http://github.com/mikeric/dopplr).

Every object in this library mirrors the official TripIt API's properties as closely as possible. Each TripIt API object and its properties has been converted into a Ruby object. To get a list of all the objects, please see the [TripIt API XML Schema](https://api.dev.tripit.com/xsd/tripit-api-obj-v1.xsd). You can also read the [TripIt API Documentation](http://github.com/tripit/api/downloads) for further details.

## Install

    gem install tripit

## Usage

Here are some examples of how to use a few of the objects available. 

### TripIt::OAuth

Create a **TripIt::OAuth** instance with your consumer token and secret. Authorize the client using your access token, provided that you've already obtained one.

    client = TripIt::OAuth.new('1a2b3c4d5e', '2a3b4c5d6e')
    client.authorize_from_access('3a4b5c6d7e', '4a5b6c7d8e')
    
### TripIt::Profile

**TripIt::Profile** is used for searching, creating, and chaining objects related to the TripIt user you authenticated with **TripIt::OAuth**.

	client = TripIt::OAuth.new('1a2b3c4d5e', '2a3b4c5d6e')
	client.authorize_from_access('3a4b5c6d7e', '4a5b6c7d8e')

	# Instantiate the user by loading his profile -- pass the client object so Profile knows how to authenticate.
	myuser = TripIt::Profile.new(client)
	# Get the user's public display name
	myuser.public_display_name => "Test User"
	# Get the user's screen name
	myuser.screen_name => "test_user"
	# Get a list of the user's registered e-mail addresses (returns Array of **TripIt::ProfileEmailAddress** objects)
	myuser.profile_email_addresses => [TripIt::ProfileEmailAddress]
	# Get a list of the user's trips (returns Array of **TripIt::Trip** objects)
	myuser.trips => [TripIt::Trip]
	# Check if the user is a TripIt Pro user, and then get his registered points programs
	if myuser.is_pro?
		

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

