# Fluent::Plugin::MeCab, a plugin for [Fluentd](http://fluentd.org)

fluentd plugin for [MeCab](http://mecab.googlecode.com).


## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-mecab', git: 'git://github.com/katsyoshi/fluent-plugin-mecab.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-mecab

## Usage

Configuration file:

    <match japanese.string>
      type mecab
      parse_type default # default: default
      keys text
      tag mecab.parse # defaul: mecab
    </match>

## TODO

1. impliments another mecab parse type, for example: wakati, chasen, and so on.
1. gem

## Contributing

1. Fork it ( http://github.com/<my-github-username>/fluent-plugin-mecab/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
