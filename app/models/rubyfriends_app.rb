require_relative 'friend'
require_relative 'hug_app_code'

class RubyfriendsApp
  attr_accessor :hashtags

  def friends
    Friend.all
  end

  def refresh_friends
    HugAppScript.update_friends
  end
end