class User < ActiveRecord::Base
  attr_accessible :name, :twitter_uid, :username, :last_seen_at

  def self.create_with_omniauth(auth)
    #puts auth.inspect
    create! do |user|
      user.twitter_uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.username = auth["info"]["nickname"]
      user.last_seen_at = Time.now
    end
  end
  
  def is_admin?
    ["zackgilbert", "kelseylk"].include? self.username
  end

end
