TuckeredIn::Application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  match "/dev_login" => "sessions#dev_login"
  match "/login" => redirect("/auth/twitter")
  match "/auth/:provider/callback" => "sessions#create"
  match "/logout" => "sessions#destroy", :as => :signout
  
  get "/submit" => "photos#new", :as => 'new_photo'
  post "/submit" => "photos#create", :as => 'photos'
  get "/photos/:id" => "photos#show", :as => "photo"
  delete "/photos/:id" => "photos#destroy"#, :as => "photos"
  
  root :to => 'photos#index'

end
