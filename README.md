# tripit

An abstraction library providing objects to interact with the TripIt API. It is essentially a multi-user wrapper with each object being bound to a client. This library's methodology of dealing with API data was heavily influenced by [Mike Richards' Dopplr gem](https://github.com/mikeric/dopplr).

## Install

    gem install tripit

## Usage

Here are some examples of how to use a few of the objects available. 

### TripIt::OAuth

Create a **TripIt::OAuth** instance with your consumer token and secret. Authorize the client using your access token, provided that you've already obtained one. Create a **TripIt::Base** instance using the authorized OAuth client.

    client = TripIt::OAuth.new('1a2b3c4d5e', '2a3b4c5d6e')
    client.authorize_from_access('3a4b5c6d7e', '4a5b6c7d8e')
    
    tripit = TripIt::Base.new(client)

### TripIt::Base

**TripIt::Base** is used for searching, creating, and chaining objects. However, you could also instantiate and use the objects directly by passing the client as an argument. As such, the following groups of statements are equivalent.


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

