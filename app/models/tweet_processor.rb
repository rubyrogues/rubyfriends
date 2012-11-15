require_relative 'rubyfriends_app'
class TweetProcessor
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def process(tweet)
    TWEET_PROCESSOR_LOGGER.info(tweet)

    new_tweet = app.new_entry(new_tweet_attrs(tweet))
    new_tweet.publish

    TWEET_PROCESSOR_LOGGER.info "Created tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"

    if ENV['oauth_token'] && ENV["RAILS_ENV"] == 'production'
      Twitter.retweet new_tweet.id
      TWEET_PROCESSOR_LOGGER.info "Retweeted tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"
    end

    self
  end

  def new_tweet_attrs(tweet)
    get_media_urls(tweet)
    new_tweet_attributes = OpenStruct.new.tap do |t|
      t.tweet_id          = tweet.id
      t.tweet_text        = tweet.full_text
      t.username          = tweet.from_user
      t.media_url         = @media_url
      t.media_display_url = @media_display_url
      t.retweet_count     = tweet.retweet_count
      t.remote_image_url  = @media_url
    end.marshal_dump
  end

  def expanded_url(tweet)
    return false if tweet.urls.empty?
    attrs = tweet.instance_variable_get(:@attrs)
    attrs[:entities][:urls].first[:expanded_url]
  end

  private

    def get_media_urls(tweet)
      if tweet.media.empty?
        if is_image?(expanded_url = expanded_url(tweet))
          @media_url = get_image_url(expanded_url)
          @media_display_url = expanded_url
        end
      else
        @media_url = tweet.media.first.media_url
        @media_display_url = tweet.media.first.display_url
      end
    end

    def is_image?(url)
      url =~ /twitpic.com|yfrog.com|instagr.am|img.ly|ow.ly|.jpg|.jpeg|.gif|.png/i
    end

    def get_image_url(url)
      case url
        when /twitpic.com/i
          "http://twitpic.com/show/full/#{url.split('/')[3]}"
        when /yfrog.com/i
          "http://yfrog.com/#{url.split('/')[3]}:medium"
        when /instagr.am/i
          "http://instagr.am/p/#{url.split('/')[4]}/media?size=m"
        when /img.ly/i
          get_imgly_url(url)
        when /ow.ly/i
          "http://static.ow.ly/photos/normal/#{url.split('/')[4]}.jpg"
        when /.jpg|.jpeg|.gif|.png/i
          url
      end
    end

    def get_imgly_url(url)
      doc = Nokogiri::HTML(open(url))
      image_url = doc.search("li[@id='button-fullview']/a").first['href']
      image_id = image_url.split('/')[2]
      image_url = "http://s3.amazonaws.com/imgly_production/#{image_id}/medium.jpg"
    end



end


# FIXME - add this back in!
# puts "Created tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"
#
# if ENV['oauth_token']
#   Twitter.retweet tweet.id
#   puts "Retweeted tweet @#{new_tweet.username}: #{new_tweet.tweet_text}"
# end