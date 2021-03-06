GS1::Application.routes.draw do

  resources :countries

  resources :classifications

  resources :medidas

  get "gerencia/index"
  get "cargo/index"
  get "perfil/index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "generar_excel/show"

  # herramienta para monitorear DelayJOb

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  resources :empresa_registradas do
    collection do
      patch 'update_multiple', :action => 'update_multiple', :as => 'update_multiple' # La ruta update_multiple para empresas
      patch 'update', :action => 'update', :as => 'update' # La ruta update
    end
  end

  resources :reportes
  
  resources :usuarios

  resources :tarifas

  resources :productos do #/empresas/1/productos

      collection do
        patch 'update_multiple', :action => 'update_multiple', :as => 'update_multiple'  # la ruta update_multiple para productos
        post 'import', :action => 'import', :as => 'import'  # Ruta para importar archivos
      end
    end

  
  
  resources :glns do
      collection do
        delete 'destroy_multiple', :action => 'destroy_multiple', :as => 'destroy_multiple'  # la ruta delete_multiple para gln
      end

  end

  ###########################################################################################

  # Versionamiento de API

  namespace :api do
    namespace :v1 do
      resources :empresas do  

        resources :empresa_servicios
    
        resources :etiquetas do
          collection do
            get 'exportar', :action => 'exportar', :as => 'exportar' 
          end
        end
    
        resources :productos do #/empresas/1/productos

          collection do
            patch 'update_multiple', :action => 'update_multiple', :as => 'update_multiple'  # la ruta update_multiple para productos
            post 'import', :action => 'import', :as => 'import'  # Ruta para importar archivos
            
          end
        end

        resources :glns do
          collection do
            delete 'destroy_multiple', :action => 'destroy_multiple', :as => 'destroy_multiple'  # la ruta delete_multiple para gln
          end

        end

        collection do
          patch 'update_multiple', :action => 'update_multiple', :as => 'update_multiple'  # la ruta update_multiple para productos
          
        end

      end  

    end
    
  end



  resources :empresas do  

    resources :empresa_servicios
    
    resources :etiquetas do
      collection do
        get 'exportar', :action => 'exportar', :as => 'exportar' 
      end
    end
    
    resources :productos do #/empresas/1/productos

      collection do
        patch 'update_multiple', :action => 'update_multiple', :as => 'update_multiple'  # la ruta update_multiple para productos
        post 'import', :action => 'import', :as => 'import'  # Ruta para importar archivos
        
      end
    end

    resources :glns do
      collection do
        delete 'destroy_multiple', :action => 'destroy_multiple', :as => 'destroy_multiple'  # la ruta delete_multiple para gln
      end

    end

      collection do
        patch 'update_multiple', :action => 'update_multiple', :as => 'update_multiple'  # la ruta update_multiple para productos
        
      end

    
  end
  
 
  resources :ciudades
  resources :clasificaciones
  resources :municipios
  resources :sessions
  resources :perfiles



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
