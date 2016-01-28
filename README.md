# How to isolate complex queries in an object oriented fashion

This repository contains the example code of the blog post [How to isolate complex queries in an object oriented fashion](http://www.alfredo.motta.name/how-to-isolate-complex-queries-in-an-object-oriented-fashion)

## Setup
* Run `bundle install`
* Create a local MySql database called `football_blog_post` and run `bundle exec database/init.rb` to setup the tables.
* Run `bundle exec rspec` to assess that `TalentHunterWithNaiveQuery` and the refactored `TalentHunterWithQueryObject` have the same behavior.

