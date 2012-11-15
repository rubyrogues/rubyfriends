TODO
====

Errors in tweetstream functionality
-----------------------------------
- NoMethodError: undefined method `expanded_urls' for #<Twitter::Tweet:0x007f8f92ecdf50>
  - this is because the new twitter gem changed significantly from the old one which the old code from fridayfriends was based on and is still being used in the new tweet_processor file, on line 16-38
- NoMethodError: undefined method `media' for #<Twitter::Tweet:0x007f8f92ecdf50>
  - it occurs b/c of the same chunk of code mentioned above

- Failed to reconnect after 6 tries. (TweetStream::ReconnectError)
  - this can be fixed with something like this:
  client.on_error do |message|
    # do something
  end
  - there is also a on_reconnect block option
  client.on_reconnect do |message|
    # do something
  end

- at somepoint we may want to use the on_delete block
  client.on_delete do |tweet_id, user_id|
    # rubyfriends_app.tweet(tweet_id).unpublish
  end
  - check out the rest of the available method hooks at
    https://github.com/intridea/tweetstream

- figure out how to get this to work on heroku and make sure it never goes down(use monit), while falling back to the old 10 minute polling version(which I suppose doesn't really need to be disabled, cause it won't pull already published tweets, although it could if a tweet was in between processing its image to s3 and the task ran at exactly the right time. We could fix this by making sure no duplicate tweet_ids were published inside of Tweet::publish)

- add one of those exception plugins to email us when the stream goes down or have some sort of monitoring of it

- get script/persist_tweetstream.rb working -- it makes the process a daemon
- turn this rubyfile into a real bash script file(not requiring .rb extension)


- add a CHANGELOG
- add a rake task for setting up cucumber and test environments and running their tests via rake

