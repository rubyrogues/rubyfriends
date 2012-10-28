class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  helper_method :rubyfriends_app
  def rubyfriends_app
    @rubyfriends_app ||= RUBYFRIENDS_APP
  end
end
