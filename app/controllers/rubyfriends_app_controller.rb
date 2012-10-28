class RubyfriendsAppController < ApplicationController

  def show
    @tweet = Tweet.find(params[:id])
    render layout: false
  end

end