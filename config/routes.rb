Todo::Application.routes.draw do
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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  namespace :todo do
    resources :active_tasks do 
      member do
        put 'complete'
        #make same for destroy
      end
    end
    #complete action may be not needed cause i will write an edit/update 
    #for basic_task controller and it will be about editing 
    #the type column of the type column
    resources :completed_tasks, only: [:index, :show, :destroy] do
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 601044d... playing with filters n completed and edit on active
     # member do
        put 'reopen', on: :member
     # end 
       #collection do 
         get 'filter_by_time', on: :collection
      # end     
<<<<<<< HEAD
    end  
  end  
=======
      member do
        put 'reopen'
      end  
    end  
>>>>>>> 7a7754e... completed tasks controller scratch
    #reopen action maybe replaced by edit/update for basic_task 
    #controller and it will be about
    #editing the type column of the type column 
    ####
=======
    end  
  end  
    #reopen action maybe replaced by edit/update for basic_task 
    #controller and it will be about
    #editing the type column of the type column 
>>>>>>> 601044d... playing with filters n completed and edit on active
end
