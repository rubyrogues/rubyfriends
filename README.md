# #RubyFriends

## Smile for the camera!

Take pictures with all your friends in the Ruby community and post them to twitter with the #RubyFriends hashtag. We'll display them on our ongoing list of happy meetings in the Ruby world.

Check out all our wonderful [#RubyFriends](http://www.rubyfriends.com).

## Contributing

  1. [Fork it](https://help.github.com/articles/fork-a-repo)

  2. Setup development environment

  ```bash
  bundle install
  bundle exec rake bootstrap
  ```

  3. Configure

  ```bash
  # edit config/application.yml (not version-controlled)
  # 1) change the SECRET_TOKEN
  bundle exec rake secret
  # 2) add twitter credentials
  # see https://github.com/sferik/t for getting your twitter credentials
  # at http://dev.twitter.com/apps
  # optionally configure whether to retweet 
  # or whether to restrict to tweets with media, only
  ```

  4. Test everything is set up correctly by running

  ```bash
  bundle exec rake db:migrate db:test:prepare spec
  bundle exec rake refresh_tweets
  bundle exec foreman start
  ```

  5. Create your feature branch

  ```bash
  git checkout -b my-new-feature
  ```

  6. Commit your changes

  ```bash
  git commit -am 'Added some feature'
  ```

  7. Run the specs

  ```bash
  bundle exec rake spec
  ```

  8. Push to the branch

  ```bash
  git push origin my-new-feature
  ```

  9. [Create a pull request](https://help.github.com/articles/using-pull-requests)

  
## Heroku Configuration

  ```bash
  heroku addons:add newrelic:standard
  # if not using aws s3 for image hosting
    heroku addons:add cloudinary:starter 
    # edit application.yml
    # file_storage: cloudinary
  # else file_storage: s3 and set s3 keys
  heroku addons:add memcachier:dev # memcached
  # the Gemfile should automatically require
  # the 'cloudinary' gem
  # if the service is  configured
  bundle exec rake figaro:heroku
  # if not using a worker
    heroku addons:add scheduler:standard
    heroku addons:open scheduler
    # schedule every 10 minutes
    # bundle exec rake refresh_tweets
  git push heroku master
  heroku run rake db:migrate
  heroku logs # check that it's working
  heroku run rake refresh_tweets
  ```

## Thanks

* Original FridayHug code/idea by [Kristopher Murata](http://twitter.com/krsmurata)
* RubyFriends idea by [Josh Susser](http://twitter.com/joshsusser)
* Initial implementation by [Erik Trom](http://twitter.com/trombom)
* Maintained by [Erik Trom](http://twitter.com/trombom) and [Justin Campbell](http://twitter.com/justincampbell)

## [LICENSE](LICENSE)
