# == Route Map
#
#                        Prefix Verb       URI Pattern                              Controller#Action
#              new_user_session GET        /users/sign_in(.:format)                 users/sessions#new
#                  user_session POST       /users/sign_in(.:format)                 users/sessions#create
#          destroy_user_session DELETE     /users/sign_out(.:format)                users/sessions#destroy
#                 user_password POST       /users/password(.:format)                users/passwords#create
#             new_user_password GET        /users/password/new(.:format)            users/passwords#new
#            edit_user_password GET        /users/password/edit(.:format)           users/passwords#edit
#                               PATCH      /users/password(.:format)                users/passwords#update
#                               PUT        /users/password(.:format)                users/passwords#update
#      cancel_user_registration GET        /users/cancel(.:format)                  users/registrations#cancel
#             user_registration POST       /users(.:format)                         users/registrations#create
#         new_user_registration GET        /users/sign_up(.:format)                 users/registrations#new
#        edit_user_registration GET        /users/edit(.:format)                    users/registrations#edit
#                               PATCH      /users(.:format)                         users/registrations#update
#                               PUT        /users(.:format)                         users/registrations#update
#                               DELETE     /users(.:format)                         users/registrations#destroy
#             user_confirmation POST       /users/confirmation(.:format)            users/confirmations#create
#         new_user_confirmation GET        /users/confirmation/new(.:format)        users/confirmations#new
#                               GET        /users/confirmation(.:format)            users/confirmations#show
#                   user_unlock POST       /users/unlock(.:format)                  users/unlocks#create
#               new_user_unlock GET        /users/unlock/new(.:format)              users/unlocks#new
#                               GET        /users/unlock(.:format)                  users/unlocks#show
#         new_adminuser_session GET        /admin/login(.:format)                   active_admin/devise/sessions#new
#             adminuser_session POST       /admin/login(.:format)                   active_admin/devise/sessions#create
#     destroy_adminuser_session DELETE|GET /admin/logout(.:format)                  active_admin/devise/sessions#destroy
#            adminuser_password POST       /admin/password(.:format)                active_admin/devise/passwords#create
#        new_adminuser_password GET        /admin/password/new(.:format)            active_admin/devise/passwords#new
#       edit_adminuser_password GET        /admin/password/edit(.:format)           active_admin/devise/passwords#edit
#                               PATCH      /admin/password(.:format)                active_admin/devise/passwords#update
#                               PUT        /admin/password(.:format)                active_admin/devise/passwords#update
#              adminuser_unlock POST       /admin/unlock(.:format)                  active_admin/devise/unlocks#create
#          new_adminuser_unlock GET        /admin/unlock/new(.:format)              active_admin/devise/unlocks#new
#                               GET        /admin/unlock(.:format)                  active_admin/devise/unlocks#show
#                    admin_root GET        /admin(.:format)                         admin/dashboard#index
# batch_action_admin_adminusers POST       /admin/adminusers/batch_action(.:format) admin/adminusers#batch_action
#              admin_adminusers GET        /admin/adminusers(.:format)              admin/adminusers#index
#                               POST       /admin/adminusers(.:format)              admin/adminusers#create
#           new_admin_adminuser GET        /admin/adminusers/new(.:format)          admin/adminusers#new
#          edit_admin_adminuser GET        /admin/adminusers/:id/edit(.:format)     admin/adminusers#edit
#               admin_adminuser GET        /admin/adminusers/:id(.:format)          admin/adminusers#show
#                               PATCH      /admin/adminusers/:id(.:format)          admin/adminusers#update
#                               PUT        /admin/adminusers/:id(.:format)          admin/adminusers#update
#                               DELETE     /admin/adminusers/:id(.:format)          admin/adminusers#destroy
#               admin_dashboard GET        /admin/dashboard(.:format)               admin/dashboard#index
#      batch_action_admin_users POST       /admin/users/batch_action(.:format)      admin/users#batch_action
#                   admin_users GET        /admin/users(.:format)                   admin/users#index
#                               POST       /admin/users(.:format)                   admin/users#create
#                new_admin_user GET        /admin/users/new(.:format)               admin/users#new
#               edit_admin_user GET        /admin/users/:id/edit(.:format)          admin/users#edit
#                    admin_user GET        /admin/users/:id(.:format)               admin/users#show
#                               PATCH      /admin/users/:id(.:format)               admin/users#update
#                               PUT        /admin/users/:id(.:format)               admin/users#update
#                               DELETE     /admin/users/:id(.:format)               admin/users#destroy
#                admin_comments GET        /admin/comments(.:format)                admin/comments#index
#                               POST       /admin/comments(.:format)                admin/comments#create
#                 admin_comment GET        /admin/comments/:id(.:format)            admin/comments#show
#                          root GET        /                                        welcome#index
#               search_personas GET        /personas/search(.:format)               personas#search
#                      personas POST       /personas(.:format)                      personas#create
#                   new_persona GET        /personas/new(.:format)                  personas#new
#                  edit_persona GET        /personas/:id/edit(.:format)             personas#edit
#                       persona GET        /personas/:id(.:format)                  personas#show
#                               PATCH      /personas/:id(.:format)                  personas#update
#                               PUT        /personas/:id(.:format)                  personas#update
#                               DELETE     /personas/:id(.:format)                  personas#destroy
#

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords',
                                    registrations: 'users/registrations', sessions: 'users/sessions',
                                    unlocks: 'users/unlocks' }
  devise_for :adminusers, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'welcome#index'

  resources :personas, except: [:index] do
    collection do
      get :search
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end