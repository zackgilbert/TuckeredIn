class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_twitter_uid(auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    user.last_seen_at = Time.now
    user.save!
    redirect_back(root_path, :notice => "Welcome! You look great today!")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Signed out!"
  end
  
  def dev_login
    session[:user_id] = 1
    redirect_to root_path, :notice => "Signed in! Hi, Zack. You look great today."
  end

end
