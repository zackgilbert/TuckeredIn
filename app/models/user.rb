class User < ActiveRecord::Base
  attr_accessible :name, :twitter_uid, :username, :last_seen_at

  def self.create_with_omniauth(auth)
    create! do |user|
      user.twitter_uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.username = auth["info"]["username"]
    end
  end

end
