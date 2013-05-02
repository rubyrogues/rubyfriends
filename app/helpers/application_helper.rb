module ApplicationHelper
  include TweetHelper

  def ajax_overlay
    content_for :javascripts do
      raw(%(<div id="overlay"><div class="contentWrap"></div></div>))
    end
  end

end
