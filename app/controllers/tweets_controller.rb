class TweetsController < ApplicationController
  def index
    @tweets = Tweet.first 20
  end

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