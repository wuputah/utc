# It's About Time

## Browser Time

http://utc.herokuapp.com

## Console Time

```
% curl -H "Accept: text/plain" http://utc.herokuapp.com/
2013-04-27T03:51:33.499703414+00:00
```

## Ruby Time

```ruby
require 'net/http'
require 'time'

actually_now = Time.iso8601(
  Net::HTTP.new("utc.herokuapp.com", 80).request(
    Net::HTTP::Get.new('/').tap { |req| req['Accept'] = 'text/plain' }
  ).body
)

puts "Your clock is off by #{Time.now - actually_now} seconds!"
```
