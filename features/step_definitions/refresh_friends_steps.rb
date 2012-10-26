module HugAppHelpers
  # from helpers, but only what is needed for scripts/update(no current_page)
  def is_a_friend?(text)
    text =~ /hug|friday/i
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

module HugAppScript
  extend self
  # from scripts/update
  include HugAppHelpers

  require 'twitter'
  def update_friends
    puts Time.now
    puts "Updating hugs..."

    terms = ["FridayHug", "HugFriday", "tenderlove hug", "tenderlove hugs"]

    terms.each do |term|
      puts "Search: #{term}"
      Twitter.search(term, include_entities: true, rpp: 50, result_type: "recent").each do |tweet|
        Friend.create_or_skip(tweet)
      end
      sleep(5)
    end

    puts "Success!"
  end

end

class Friend
  extend HugAppHelpers

  def self.create_or_skip(tweet, skip_friend_validation = false)

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

    if (is_a_friend?(tweet.text) || skip_friend_validation) && @media_url


      if where(media_url: @media_url).empty?
        user = tweet.from_user.nil? ? tweet.user.screen_name : tweet.from_user
        friend = new(
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

        friend.remote_image_url = @media_url
        friend.save!


      end

    end

  end

end # Friend

# my code
class RubyfriendsApp
  def friends
    Friend.all
  end

  def refresh_friends
    HugAppScript.update_friends
  end
end

def rubyfriends_app
  @rubyfriends_app ||= RubyfriendsApp.new
end

Given /^the app knows about (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  rubyfriends_app.friends.count.should eq expected_count
end

When /^I manually run the refresh friends task$/ do
  VCR.use_cassette('tweets', :preserve_exact_body_bytes => true, :match_requests_on => [:method]) do
    rubyfriends_app.refresh_friends
  end
end

Then /^the app should know about more than (#{CAPTURE_A_NUMBER}) tweets$/ do |expected_count|
  rubyfriends_app.friends.count.should > expected_count

  rubyfriends_app.pry
end