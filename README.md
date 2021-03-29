# README

To get the application up and running you'll need:

* Ruby version 2.6.3 installed (https://github.com/rbenv/rbenv)
* Postgres (can be installed via homebrew https://brew.sh)

Then from within the application directory:

* run `bundle` to install the remaining dependencies (you may need to run `gem install bundler`)
* run `yarn` to install node modules
* to create a new database `bin/rails db:create`
* to migrate `bin/rails db:schema:load`
* and to seed the initial map `bin/rails db:seed`

To access the site:

* run `bin/rails s` to start the server
* navigate to localhost:3000

