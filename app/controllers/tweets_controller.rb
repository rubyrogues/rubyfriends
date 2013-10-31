class TweetsController < ApplicationController

  def index
    @tweets = Tweet.published.first 20
  end

  def show
    @tweet = Tweet.where(id: params[:id]).limit(1).first
    render layout: false
  end

end
