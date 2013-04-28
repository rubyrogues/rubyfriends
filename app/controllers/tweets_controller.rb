class TweetsController < ApplicationController
  def index
    @tweets = Tweet.published.first 20
  end

  def show
    @tweet = Tweet.find(params[:id])
    render layout: false
  end

end
