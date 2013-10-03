Todo::Application.routes.draw do
  devise_for :users
  
  root :to => 'todo/active_tasks#index', as: 'todo'

  concern :mass_destroyable do
    post 'mass_destroy', on: :collection
  end  
  
  namespace :todo do
    resources :completed_tasks, only: [:index, :destroy], concerns: :mass_destroyable do
      patch 'reopen', on: :member
      get 'filter_by_time', on: :collection
      get 'filter_by_priority', on: :collection
      post 'mass_reopen', on: :collection
    end   

    resources :active_tasks, :path => '', except: [:show, :update], concerns: :mass_destroyable do      
      patch 'complete', on: :member
      post 'update_task',  on: :collection
      post 'mass_complete', on: :collection
    end  
  end  
end