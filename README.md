# afo
[![Build Status](https://travis-ci.org/xprazak2/afo.svg)](https://travis-ci.org/xprazak2/afo)

Small and lightweight application for hosting a webcomic.
Features:
* It shows comics! (duh)
* Graphical interface for authorized users to manage the content, created as (almost) SPA with angular
* Supports markdown (via [kramdown](http://kramdown.gettalong.org/))

Does not support color themes, but if you really want to use this instead of some hyper-super-ultra-mega-über sophisticated CMS developed by a multicultural team of various faiths and beliefs distributed accross three continents and five timezones, then I guess you have a nature adventurous enough to change my stylesheets by hand. The lack of extensibility comes with the fact that this application has been created for educational and entertainment purposes of its author, who provides __absolutely no guarantee whatsoever__ that this will work as expected.

### development setup
* bundle install
* npm install
* grunt bower:install
* create your own config/settings.yml file, see config/settings.defaults.yml for inspiration
* before you actually run the app, make sure it can find your postgres
* rake devel_start
* app should start on port 9393
* log in as authorized user under '/private'

Comes with a small set of sample data that can be loaded/destroyed via Rake tasks. Both actions are idempotent. See Rakefile for details.

## TODO
* passenger
* support for other databases
* cleanup layout a bit
* additional directives to make js more dry
* js testing
