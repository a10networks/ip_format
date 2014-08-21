# IpFormat

This is a gem that leverages the Resolv library to validate IP addresses. This can handle both, IPV4 and IPV6.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ip_format'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install ip_format
```

## Usage

In order to validate an attribute, use the `validates` keyword:

```ruby
class Device < ActiveRecord::Base

  # ...

  validates :ip, ip_format: true

  # ...

end
```

Now the ip attribute will be validated:

```ruby
Device.new(ip: 'invalidip').valid?        # => false
Device.new(ip: '192.68.0.1').valid? # => true
```

Also, the model in question doesn't need to inherit from ActiveRecord::Base, you only need to `include ActiveModel::Validations` in your class:

```
require 'ip_format'

class Awesome
  include ActiveModel::Validations
  attr_accessor :ip
  validates :ip, ip_format: true
end

awesome = Awesome.new

awesome.ip = "fde4:8dba:82e1::"
awesome.valid? # => true

awesome.ip = "invalidip"
awesome.valid? # => false
```

### Check format for only IPV4 or IPV6

There are two other validators, `ipv4_format` and `ipv6_format`. They can be called in place of `ip_format` if you want the IP address to be validated specifically against IPV4 or IPV6.

#### IPV6 Format

The below example validates against the IPV6 format regex defined by the `Resolv` gem.

```ruby
require 'ip_format'

class Awesome
  include ActiveModel::Validations
  attr_accessor :ip
  validates :ip, ipv6_format: true
end

awesome = Awesome.new

awesome.ip = "fde4:8dba:82e1::"
awesome.valid? # => true

awesome.ip = "192.68.0.1"
awesome.valid? # => false
```

#### IPV4 Format

The below example validates against the IPV4 format regex defined by the `Resolv` gem.

```ruby
require 'ip_format'

class Awesome
  include ActiveModel::Validations
  attr_accessor :ip
  validates :ip, ipv4_format: true
end

awesome = Awesome.new

awesome.ip = "fde4:8dba:82e1::"
awesome.valid? # => false

awesome.ip = "192.68.0.1"
awesome.valid? # => true
```

## Contributing

1. Fork it ( https://github.com/a10networks/ip_format/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
