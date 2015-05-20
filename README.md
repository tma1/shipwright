# Shipwright

Shipwright is a ruby cli used for assisting implementations of the 
[harbor pattern](#) for cloud operations on AWS Elastic Beanstalk. 

Shipwright provides three binaries to assist in deployment:
1. `hoist` a utility for fetching and setting enviroment variables on elastic
beanstalk instances
1. `ship` the cli interface for creating elastic beanstalk applications and
deploying environments
1. `harbor` a bootstrap utility for managing a local harbor

## Installation

Usually you will want to use `shipwright` on the command line. 
Install it using:
```bash
$ gem install shipwright
```

If you want to use the underlying ruby libraries, add it to your Gemfile with:
```ruby
gem 'shipwright'
```

## Usage

Shipwright provides the following binaries

1. `hoist up`
1. `hoist down`
1. `ship launch`
1. `ship assets`
1. `ship image`
1. `ship app`
1. `harbor create`
1. `harbor init`
1. `harbor add`

## Development

```bash
$ git clone https://github.com/tma1/shipwright
$ cd shipwright
$ bin/setup
```

## Contributing

1. Fork it ( https://github.com/tma1/shipwright/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
