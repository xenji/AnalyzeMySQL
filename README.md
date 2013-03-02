# AnalyzeMySQL

This little tool (or you might call it framework someday) intends to help with analyzing MySQL table structures.
I've built it for trivago, who have a primary MySQL database of > 280 tables with max row counts of (roughly)
100,000,000 for the bigger tables. This gives you a certain perspective on data. Joins can get expensive when
you try to create them by using two fields of different data types (signed int and unsigned bigint for example).
In such cases MySQL tends to cast values into one of the formats, which is an unnecessary loss of performance.

AnalyzeMySQL (ams) tends to help by objectifying the tables data structure and handling it via an API to each
plugin, each plugin can do it's work and contribute to a final report. This keeps things scalable and enables
you to write your own additions, based on the structure of your database.

## A first check

In trivago's case we follow the rule of explicit naming:

- Table: `foo`
- PK: `foo_id`

- Other table: `bar`
- PK: `bar_id`
- IDX_foo: `foo_id`

`bar.foo_id` is the join col. for `foo.foo_id`, which roughly means they must have the same col definition. This check
is called `join_match_col_defintion` and you can find more of them in the wiki.

## Installation

Add this line to your application's Gemfile:

    gem 'AnalyzeMySQL'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install AnalyzeMySQL

When the gem finished installing, please create a new folder for your project and run

    $ ams --init

This will create a new config file in the current working directory by copying it from the current example file.
The config file enables you to declare everything you want and need, including a directory to put the reports and
a directory to include when searching for plugins.

Just run

    $ ams

in the same directory where the config file resides to start the test run.

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
