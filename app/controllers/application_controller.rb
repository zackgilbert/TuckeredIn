class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def admins_only
    if !current_user || !current_user.is_admin?
      redirect_to root_path
      return
    end
  end
  
  def users_only
    if !current_user
      redirect_to root_path
      return
    end    
  end
  
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
  
  # borrowed from: http://stackoverflow.com/a/11607258
  def email_is_valid?(email) 
    require 'mail'
    
    parser = Mail::RFC2822Parser.new
    parser.root = :addr_spec
    result = parser.parse(email)

    # Don't allow for a TLD by itself list (sam@localhost)
    # The Grammar is: (local_part "@" domain) / local_part ... discard latter
    result && 
       result.respond_to?(:domain) && 
       result.domain.dot_atom_text.elements.size > 1
  end

end