module HugAppHelpers

  def is_image?(url)
    url =~ Regexp.union(supported_image_formats.keys)
  end

  def get_image_url(url)
    supported_image_formats.each do |format, conversion|
      return conversion.call(url) if url =~ format
    end
  end

  private

  def supported_image_formats
    {
      /twitpic.com/ => ->(u) {
        "http://twitpic.com/show/full/#{u.split('/')[3]}"
      },
      /instagr.am/ => ->(u) {
        "http://instagr.am/p/#{u.split('/')[4]}/media?size=m"
      },
      /ow.ly/ => ->(u) {
        "http://static.ow.ly/photos/normal/#{u.split('/')[4]}.jpg"
      },
      /d.pr/ => ->(u) {
        "#{u}+"
      },
      /img.ly/ => ->(u) {
        get_imgly_url(u)
      },
      /yfrog.com/ => ->(u) {
        "http://yfrog.com/#{u.split('/')[3]}:medium"
      },
      /.jpg|.jpeg|.gif|.png/ => ->(u) { u }
    }
  end

  def get_imgly_url(url)
    doc = Nokogiri::HTML(open(url))
    image_url = doc.search("li[@id='button-fullview']/a").first['href']
    image_id = image_url.split('/')[2]
    image_url = "http://s3.amazonaws.com/imgly_production/#{image_id}/medium.jpg"
  end
end

module HugAppScript
  extend self
  # from scripts/update in fridayhugs
  include HugAppHelpers

  require 'twitter'
  def update_tweets
    puts Time.now
    puts "Updating tweets..."

    terms = RUBYFRIENDS_APP.hashtags

    terms.each do |term|
      puts "Search: #{term}"
      Twitter.search(term, include_entities: true, rpp: 50, result_type: "recent").each do |tweet|
        Tweet.create_or_skip(tweet)
      end
    end

    puts "Success!"
  end

end

class Tweet
  extend HugAppHelpers

  def self.create_or_skip(tweet, skip_tweet_validation = false)

    if tweet.media && tweet.media.empty?
      tweet.expanded_urls.each do |expanded_url|
        if is_image?(expanded_url)
          @media_url = get_image_url(expanded_url)
          @media_display_url = expanded_url
        end
      end
    else
      @media_url = tweet.media.first.media_url
      @media_display_url = tweet.media.first.display_url
    end

    if @media_url

      if where(media_url: @media_url).empty?
        user = tweet.from_user.nil? ? tweet.user.screen_name : tweet.from_user
        new_tweet = new(
          tweet_id: tweet.id,
          tweet_text: tweet.text,
          username: user,
          media_url:  @media_url,
          media_display_url: @media_display_url,
          retweet_count: tweet.retweet_count,
          published_at: tweet.created_at,
          published: true
        )

        # binding.pry

        # carrierwave remote_fieldname_url will download image from url, convert
        # it and resave it
        new_tweet.remote_image_url = @media_url
        new_tweet.save!

        puts "Created tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"

        if ENV['retweet'] =~ /true/io
          Twitter.retweet tweet.id
          puts "Retweeted tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"
        end
      end

    end

  end
end
