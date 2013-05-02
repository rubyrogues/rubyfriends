require 'open-uri'
require 'nokogiri'
module TweetMediaExtractor
  extend self

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

