TuckeredIn::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  match "/dev_login" => "sessions#dev_login"
  match "/login" => redirect("/auth/twitter")
  match "/auth/:provider/callback" => "sessions#create"
  match "/logout" => "sessions#destroy", :as => :signout

  get "/upload" => "photos#new", :as => 'upload'
  post "/upload" => "photos#upload", :as => 'upload_photo'
  get "/submit" => "photos#submit", :as => 'new_photo'
  post "/submit" => "photos#create", :as => 'photos'
  get "/cuties/:id" => "photos#show", :as => "photo"
  delete "/photos/:id" => "photos#destroy", :as => "delete_photo"
  get "/photos/:id/edit" => "photos#edit", :as => "edit_photo"
  put "/photos/:id" => "photos#update", :as => "update_photo"
  post "/photos/:id/approve" => "photos#approve", :as => "approve_photo"
  delete "/photos/:id/unapprove" => "photos#unapprove", :as => "unapprove_photo"
  post "/photos/:id/like" => "photos#like", :as => "like_photo"
  delete "/photos/:id/unlike" => "photos#unlike", :as => "unlike_photo"

  get "/subscribe" => "photos#subscribe", :as => 'subscribe'
  get "/thankyou" => "photos#thankyou", :as => 'thankyou'
  post "/charge" => "photos#charge", :as => 'charge'
  get "/charges" => "photos#charges", :as => 'charges'

  get "/pending" => "photos#pending", :as => 'pending'

  get "/splash" => 'pages#splash'
  get "/" => 'photos#index', :as => 'home'
  get "/cuties" => redirect("/")
  root :to => 'photos#index'

end
