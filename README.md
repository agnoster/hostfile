# Hostfile [![build status](https://secure.travis-ci.org/agnoster/hostfile.png?branch=master)](http://travis-ci.org/agnoster/hostfile)

> STATE: Unusable

No-fuss hash-style hostfile manipulation for Ruby

    Hostfile.default["customhost.localhost"] = "127.0.0.1"

> Note: see also the [hosts gem] by Alexander E. Fischer for a cleaner, more
> sophisticated and feature-rich approach.

## Installation

Add this line to your application's Gemfile:

    gem 'hostfile'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hostfile

## Usage

### Instantiation

In general, you start off by creating a `Hostfile` object:

    require 'hostfile'
    hosts = Hostfile.new

By default, `Hostfile.new` is the same as `Hostfile.new Hostfile.default_path`, but
you can pass an arbitrary path in there such as `Hostfile.new '/etc/hosts'`.
However, it is strongly recommended that you use the system default, which may be
different on other platforms. (I'm looking at you, Windows!)

A Hostfile object actually contains no data. None. Hostfile always works with the
live data on the disk, in order to reduce the chance that you read state, change it
while someone else wrote to the file, and then overwrite those changes. It might be
rare, but it's the approach I'm taking.

A Hostfile behaves like a Hash (with indifferent access - all keys are converted
to_s). In fact, technically speaking it `is_a? Hash`. This gives rise to another
major difference to the hosts gem (or indeed, a "correct" implementation of the
semantics of `/etc/hosts`), as a host may have multiple IP addresses! If you set an
IP here, you will remove any other IPs. This is probably what you want 99.9% of the
time, obviously. (The major exception being separate IPv4/IPv6 addresses.)

### Basic operations

To add an entry in the Hostfile, do:

    hosts["my.localhost"] = "127.0.0.1"

To remove an entry, either of these is equivalent:

    hosts.delete "my.localhost"
    hosts["my.localhost"] = nil

To look up an entry, do:

    hosts["my.localhost"]

Note, you can also do:

    hosts["my-other.localhost"] = "my.localhost"

In contrast to the other methods, this will not add a new row, but merely append
"my-other.localhost" to the same line that defines "my.localhost", making it easier
to change the alias if manipulating manually. This is merely a convenience for
manual editing - this should not be considered an "alias" or anything. For example:

    hosts[:hosta] = "10.0.0.1"
    hosts[:hostb] = :hosta
    hosts[:hosta] = "10.0.0.2"
    puts hosts[:hostb] # => "10.0.0.1"

## Scoping

Sometimes you want to scope all your changes within a given block of the hosts file
- perhaps you're writing an application and you want to keep all its hosts separate
from the rest of the file.

To do this, simply use the `#scope` method:

    scoped = hosts.scope :my_app
    scoped["foo.bar"] = "127.0.0.1"

Any operations will only be performed on lines falling within the scope. The first
time you add an entry it will go inside the scoped block.

Note: This means that if you scope your operation to set a host, and the hosts was
defined outside the block, the one outside the block will not be removed and may
take precedence (depending on order).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[hosts gem]: https://github.com/aef/hosts "hosts gem by Alexander E. Fischer on Github"
