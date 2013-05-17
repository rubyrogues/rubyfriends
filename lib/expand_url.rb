require 'net/http'
require 'net/https'
require 'uri'

# e.g.
# url = http://t.co/z4t0E1vArh
# ExpandUrl.expand_url(url)
# => "http://www.haaretz.com/news/national/israel-s-ag-impels-ministers-to-crack-down-on-exclusion-of-women.premium-1.519917"
module ExpandUrl
  class ExpansionError < StandardError; end
  module ExpansionErrors
    class BadUrl < ExpansionError; end
    class BadResponse < ExpansionError; end
  end
  HTTP_ERRORS = [Timeout::Error, Errno::EINVAL, Errno::ECONNRESET,
       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError]
  class BasicResponse < Struct.new(:url, :code); end
  extend self

  # raises ExpandUrl::ExpansionError
  def expand_url(url)
    response = get_response(url)
    case response.code
    when '301'
      log "url: #{url}\tresponse: #{response.inspect}"
      expand_url(response['location'])
    when '200'
      log "url: #{url}\tresponse: #{response.inspect}"
      url
    else
      log "url: #{url}\tresponse: #{response.inspect}"
      expand_url(response['location'])
    end
  end

  def get_response(url)
    uri = url_to_uri(url)
    Net::HTTP.get_response(uri)
  rescue EOFError => e
    BasicResponse.new(url, '200')
  rescue *HTTP_ERRORS => e
    log url.inspect + e.inspect
    raise ExpansionErrors::BadResponse.new(e)
  end

  def url_to_uri(url)
    begin
      uri = URI.parse(url)
    rescue URI::InvalidURIError, SocketError => e
      raise ExpansionErrors::BadUrl.new(e)
    end
  end

  def log(msg)
    STDOUT.puts "#{msg}\t#{caller[1]}" if (ENV['debug'] == 'true')
  end

end
