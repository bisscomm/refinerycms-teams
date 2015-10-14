Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :teams, :path => Refinery::Teams.page_url do
    root :to => "teams#index"
    resources :teams, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :teams, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      scope :path => 'teams' do
        root :to => "teams#index"

        resources :teams, :except => :show do
          collection do
            get :uncategorized
            post :update_positions
          end
        end

        resources :categories, except: :show do
          get :children, :on => :member
          post :update_positions, on: :collection
        end
      end
    end
  end
end