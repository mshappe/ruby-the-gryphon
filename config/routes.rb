# frozen_string_literal: true

# == Route Map
#
#                   Prefix Verb   URI Pattern                                 Controller#Action
#                     root GET    /                                           welcome#index
#            release_notes GET    /release_notes(.:format)                    welcome#release_notes
#                   awards GET    /awards(.:format)                           awards#index
#                          POST   /awards(.:format)                           awards#create
#                new_award GET    /awards/new(.:format)                       awards#new
#               edit_award GET    /awards/:id/edit(.:format)                  awards#edit
#                    award GET    /awards/:id(.:format)                       awards#show
#                          PATCH  /awards/:id(.:format)                       awards#update
#                          PUT    /awards/:id(.:format)                       awards#update
#                          GET    /awards/award_badges/:id(.:format)          awards#award_badges
#                   branch GET    /branches/:id(.:format)                     branches#show
#                          GET    /branches/branch_heraldries/:id(.:format)   branches#branch_heraldries
#                          GET    /branches/map_images/:id(.:format)          branches#map_images
#                dashboard GET    /dashboard/:user_id(.:format)               dashboard#show
#            queued_events GET    /events/queued(.:format)                    events#queued
#                   events GET    /events(.:format)                           events#index
#                          POST   /events(.:format)                           events#create
#                new_event GET    /events/new(.:format)                       events#new
#               edit_event GET    /events/:id/edit(.:format)                  events#edit
#                    event GET    /events/:id(.:format)                       events#show
#                          PATCH  /events/:id(.:format)                       events#update
#                          PUT    /events/:id(.:format)                       events#update
#                          DELETE /events/:id(.:format)                       events#destroy
#                 officers GET    /officers(.:format)                         officers#index
#                  officer GET    /officers/:id(.:format)                     officers#show
#          search_personas GET    /personas/search(.:format)                  personas#search
#                 personas POST   /personas(.:format)                         personas#create
#              new_persona GET    /personas/new(.:format)                     personas#new
#             edit_persona GET    /personas/:id/edit(.:format)                personas#edit
#                  persona GET    /personas/:id(.:format)                     personas#show
#                          PATCH  /personas/:id(.:format)                     personas#update
#                          PUT    /personas/:id(.:format)                     personas#update
#                          DELETE /personas/:id(.:format)                     personas#destroy
#                          GET    /personas/persona_images/:id(.:format)      personas#persona_images
#            section_posts GET    /posts/:post_type_name(.:format)            posts#index
#                    posts GET    /posts(.:format)                            posts#index
#                     post GET    /posts/:id(.:format)                        posts#show
#                          GET    /warrant_types/warrant_badges/:id(.:format) officers#warrant_badges
#         new_user_session GET    /users/sign_in(.:format)                    users/sessions#new
#             user_session POST   /users/sign_in(.:format)                    users/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                   users/sessions#destroy
#            user_password POST   /users/password(.:format)                   users/passwords#create
#        new_user_password GET    /users/password/new(.:format)               users/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)              users/passwords#edit
#                          PATCH  /users/password(.:format)                   users/passwords#update
#                          PUT    /users/password(.:format)                   users/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                     users/registrations#cancel
#        user_registration POST   /users(.:format)                            users/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                    users/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                       users/registrations#edit
#                          PATCH  /users(.:format)                            users/registrations#update
#                          PUT    /users(.:format)                            users/registrations#update
#                          DELETE /users(.:format)                            users/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)               users/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format)           users/confirmations#new
#                          GET    /users/confirmation(.:format)               users/confirmations#show
#              user_unlock POST   /users/unlock(.:format)                     users/unlocks#create
#          new_user_unlock GET    /users/unlock/new(.:format)                 users/unlocks#new
#                          GET    /users/unlock(.:format)                     users/unlocks#show
#

Rails.application.routes.draw do
  namespace :manage do
    get '/', controller: 'dashboard', action: 'index'

    resources :roles, only: %i[create destroy]
    resources :personas, only: %i[show edit update destroy]
    resources :reigns, except: [:destroy]
    resources :users, only: %i[show edit update destroy]
    resources :warrants, only: %i[show edit update destroy]
    resources :reports, only: %i[show edit update destroy]
  end

  root to: 'welcome#index'
  get '/release_notes', controller: 'welcome', action: 'release_notes'

  resources :awards, except: [:destroy]
  get '/awards/award_badges/:id', controller: 'awards', action: 'award_badges'

  resources :branches, only: [:index, :show]
  get '/branches/branch_heraldries/:id', controller: 'branches', action: 'branch_heraldries'
  get '/branches/map_images/:id', controller: 'branches', action: 'map_images'

  get '/dashboard/:user_id', controller: 'dashboard', action: 'show', as: :dashboard

  resources :events, except: [:destroy] do
    collection do
      get :queued
    end
  end

  namespace :manage do
    get '/', to: 'manage/dashboard#index'
  end

  resources :officers, only: %i[index show]

  resources :personas, except: [:index] do
    collection do
      get :search
    end
  end
  get '/personas/persona_images/:id', controller: 'personas', action: 'persona_images'
  get '/reigns/reign_images/:id', controller: 'reigns', action: 'reign_images'
  get '/reigns/reign_images/:id/view', controller: 'reigns', action: 'view_reign_image', as: 'view_reign_image'

  resources :posts, only: %i[index show] do
    collection do
      get '/:post_type_name', action: :index, as: 'section'
    end
  end

  # We currently have no crud for warrant_types and the route for showing is :officers, so
  get '/warrant_types/warrant_badges/:id', controller: 'officers', action: 'warrant_badges'

  devise_for :users, controllers: { confirmations: 'users/confirmations', passwords: 'users/passwords',
                                    registrations: 'users/registrations', sessions: 'users/sessions',
                                    unlocks: 'users/unlocks' }

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
