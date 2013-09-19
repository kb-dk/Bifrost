Bifrost::Application.routes.draw do
  root :to => "catalog#index"

  Blacklight.add_routes(self)

  devise_for :users

  match '/login',                   :to => 'users/sessions#new',       :as => 'new_user_session'
  match '/auth/:provider/callback', :to => 'users/sessions#create',    :as => 'create_user_session'
  match '/logout',                  :to => 'users/sessions#destroy',   :as => 'destroy_user_session'

end
