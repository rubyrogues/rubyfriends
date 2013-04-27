# #RubyFriends

## Smile for the camera!

Take pictures with all your friends in the Ruby community and post them to twitter with the #RubyFriends hashtag. We'll display them on our ongoing list of happy meetings in the Ruby world.

Check out all our wonderful [#RubyFriends](http://www.rubyfriends.com).

## Contributing

  1. [Fork it](https://help.github.com/articles/fork-a-repo)
  2. Setup development environment

  ```bash
  $ bundle install
  $ bundle exec rake bootstrap
  # edit config/application.yml (not version-controlled)
  # 1) change the SECRET_TOKEN
  # 2) add twitter credentials
  # see https://github.com/sferik/t for getting your twitter credentials
  # at http://dev.twitter.com/apps
  $ rake figaro:heroku # if using heroku
  $ rake refresh_tweets
  $ rails s
  ```

  3. Create your feature branch

  ```bash
  $ git checkout -b my-new-feature
  ```

  4. Commit your changes

  ```bash
  $ git commit -am 'Added some feature'
  ```

  5. Run the specs

  ```bash
  $ bundle exec rake spec
  ```

  6. Push to the branch

  ```bash
  $ git push origin my-new-feature
  ```

  7. [Create a pull request](https://help.github.com/articles/using-pull-requests)

## Thanks

* Original FridayHug code/idea by [Kristopher Murata](http://twitter.com/krsmurata)
* RubyFriends idea by [Josh Susser](http://twitter.com/joshsusser)
* Initial implementation by [Erik Trom](http://twitter.com/trombom)
* Maintained by [Erik Trom](http://twitter.com/trombom) and [Justin Campbell](http://twitter.com/justincampbell)

## [LICENSE](LICENSE)
