TuckeredIn::Application.routes.draw do
  
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  
  root :to => 'photos#index'

end
