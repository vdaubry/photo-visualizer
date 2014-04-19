PhotoVisualizer::Application.routes.draw do
  root 'websites#index'

  resources :websites do
    resources :posts, :only => :destroy do
      member do
        put 'banish'
      end

      resources :images do
        member do
          put 'redownload'
        end
        collection do
          delete 'destroy_all'
        end
      end
    end

    resources :images, :only => :index
  end
end
