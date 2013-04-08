# AnalyzeMySQL

You can read [http://blog.xenji.com/2013/04/mysql-analysis-with-analyzemysql.html](http://blog.xenji.com/2013/04/mysql-analysis-with-analyzemysql.html) for a small introduction and the mission behind it.

This little tool (or you might call it framework someday) intends to help with analyzing MySQL table structures.
I've built it for trivago, who have a primary MySQL database of > 230 tables with max row counts of (roughly)
100,000,000 for the bigger tables.

AnalyzeMySQL (ams) tends to help by objectifying the tables data structure and handling it via an API to every
plugin. Now each plugin can do it's work and contribute to a final report. This keeps things scalable and enables
you to write your own additions, based on the structure of your database.

## A first check

`col_size_fits_contet` is the first plugin. It checks the max(col) value against the column's definition and mangles the
definition if the value differs more than the configured percentage.

Example:

```
WARN -- : Table: bar / Column: foo :: maximum column content 907564 is below 50% of it's max defined value of 9223372036854775807
```

## Installation
Install it by just cloning it. It is not yet ready to be released as installable gem. Edit the configuration to fit your
settings. The installation routine will change in the future, but I want to focus on stability first.
The config file enables you to declare everything you want and need, including a directory to put the reports and
a directory to include when searching for plugins.

Just run:

```
    $ bundle install
    $ bin/ams
```

ATTENTION: Depending on the plugins you choose, you will set the database under high load.

## Plugins

Put your plugins in `lib/AnalyzeMySQL/plugins` and use the `col_size_fits_content.rb` as an example.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
