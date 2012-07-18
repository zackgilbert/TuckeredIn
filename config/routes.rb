TuckeredIn::Application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  match "/dev_login" => "sessions#dev_login"
  match "/login" => redirect("/auth/twitter")
  match "/auth/:provider/callback" => "sessions#create"
  match "/logout" => "sessions#destroy", :as => :signout

  get "/upload" => "photos#new", :as => 'upload'
  
  get "/submit" => "photos#new", :as => 'new_photo'
  post "/submit" => "photos#create", :as => 'photos'
  get "/photos/:id" => "photos#show", :as => "photo"
  delete "/photos/:id" => "photos#destroy"#, :as => "photos"
  get "/photos/:id/edit" => "photos#edit", :as => "edit_photo"
  put "/photos/:id" => "photos#update", :as => "update_photo"
  
  get "/pending" => "photos#pending", :as => 'pending'
  
  root :to => 'photos#index'

end
