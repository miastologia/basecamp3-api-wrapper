# Basecamp3 API Wrapper

A simple Ruby Wrapper for the Basecamp 3 API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'basecamp3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install basecamp3

## Basic usage

First, you have to establish a connection to Basecamp3.
```ruby
Basecamp3.connect(YOUR_BASECAMP3_ACCOUNT_ID, YOUR_BASECAMP3_ACCESS_TOKEN)
```

That's all. You can make requests now. 
E.g.: to get the TODO, just call the `find` method from the `Basecamp3::Todo` class:
```ruby
todo = Basecamp3::Todo.find(BUCKET_ID, TODO_ID)
todo.content # = 'Hello world!'
```

## TODO

### Missing models
* Attachments
* Chatbots
* Client approvals
* Client correspondences
* Client replies
* Events
* Recordings
* Templates
* Uploads
* Webhooks

### Other
* updating Basecamp data directly from a model instance (something like `save` method)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/miastologia/basecamp3-api-wrapper.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

