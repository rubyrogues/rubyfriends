class TweetsController < ApplicationController
  def index
    @tweets = Tweet.published.first 20
  end

  def show
    @tweet = Tweet.find(params[:id])
    render layout: false
  end

  private

    helper_method :paginated_tweets
    def paginated_tweets
      @paginated_tweets ||= rubyfriends_app.paginated_entries(params[:page])
    end

end