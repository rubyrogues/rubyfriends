- if you run the cucumber test long enough and people are tweeting, you'll eventually see this error pop up:
NoMethodError: undefined method `expanded_urls' for #<Twitter::Tweet:0x007f8f92ecdf50>
  - this is because the new twitter gem changed significantly from the old one which the old code from fridayfriends was based on and is still being used in the new tweet_processor file, on line 16-38
- Another error that pops up is NoMethodError: undefined method `media' for #<Twitter::Tweet:0x007f8f92ecdf50>
  - it occurs b/c of the same chunk of code mentioned above

- get script/persist_tweetstream.rb working -- it makes the process a daemon


- add a CHANGELOG
- add a rake task for setting up cucumber and test environments and running their tests via rake

