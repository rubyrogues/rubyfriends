module ApplicationHelper
  def twitter_url(hashtag = rubyfriends_app.default_hashtag)
    "https://twitter.com/#!/#{hashtag}"
  end

  def ajax_overlay
    content_for :javascripts do
      raw(%(<div id="overlay"><div class="contentWrap"></div></div>))
    end
  end

end
