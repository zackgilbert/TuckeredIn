class SplashMailer < ActionMailer::Base
  default from: "contact@tuckered.in"
  
  def splash_signup(email)
    @email = email
    mail(:to => 'zackgilbert+tuckeredin@gmail.com', :subject => "New tuckered.in signup!")
  end
  
end
