class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  # redirect somewhere that will eventually return back to here
  def redirect_away(*params)
    session[:original_uri] = request.fullpath
    redirect_to(*params)
  end

  # returns the person to either the original url from a redirect_away or to a default url
  def redirect_back(*params)
    uri = session[:original_uri]
    session[:original_uri] = nil
    if uri
      redirect_to uri
    else
      redirect_to(*params)
    end
  end

end