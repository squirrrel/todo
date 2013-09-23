Todo::Application.routes.draw do
  devise_for :users
  

  namespace :todo do
    resources :completed_tasks, only: [:index, :destroy] do
      put 'reopen', on: :member
      get 'filter_by_time', on: :collection
      get 'filter_by_priority', on: :collection
    end   

    resources :active_tasks, :path => '' do      
      put 'complete', on: :member
      post 'update_task',  on: :collection
      post 'mass_destroy', on: :collection
      post 'mass_complete', on: :collection
    end  
  end  
  
end
