class User < ActiveRecord::Base
  attr_accessible :name, :twitter_uid, :username, :last_seen_at

  acts_as_voter

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
    return true if ["Zack Gilbert"].include? self.name
    ["zackgilbert", "kelseylk", "DiannaMcD", "TuckeredIn", "beckyrother"].include? self.username
  end

end
