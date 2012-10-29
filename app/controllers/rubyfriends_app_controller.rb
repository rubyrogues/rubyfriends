class RubyfriendsAppController < ApplicationController

  def show
    @tweet = Tweet.find(params[:id])
    render layout: false
  end

  private

    helper_method :paginated_tweets
    def paginated_tweets
      @paginated_tweets ||= rubyfriends_app.paginated_tweets(params[:page])
    end

end