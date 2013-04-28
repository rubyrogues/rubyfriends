class Tweet < ActiveRecord::Base
  default_scope order("published_at desc")

  mount_uploader :image, ImageUploader

  def self.published
    where(published: true).where("published_at is not null")
  end

  def self.create_or_skip(tweet_statuses, skip_tweet_validation = false)
    Array(tweet_statuses).each do |tweet_status|
      next unless tweet_status.has_media?
      next unless Tweet.where(media_url: tweet_status.media_url).count('id') == 0

      tweet = Tweet.new
      # next if (tweet.tweet_id == tweet_status.tweet_id) unless tweet.new_record?
      # next unless tweet.new_record?
      field_mappings = {
        username: :username=,
        tweet_id: :tweet_id=,
        tweet_text: :tweet_text=,
        retweet_count: :retweet_count=,
        published_at: :published_at=,
        # carrierwave remote_fieldname_url will download image from url, convert
        # it and resave it
        media_url: :remote_image_url=
      }
      field_mappings.each do |status_field, tweet_field|
        data = tweet_status.public_send(status_field)
        tweet.public_send(tweet_field, data)
      end
      tweet.published = true
      # TODO failure scenario?
      if tweet.save
        puts "Created tweet @#{tweet.username}: #{tweet.tweet_text}"

        if ENV['retweet'] =~ /true/io
          Twitter.retweet tweet.id
          puts "Retweeted tweet @#{tweet.username}: #{tweet.tweet_text}"
        end
      end
    end # end loop over tweet_statuses
  end # end create_or_skip
end
