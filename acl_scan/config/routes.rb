AclScan::Engine.routes.draw do
  resources :characters, except: [:show, :destroy]
  resources :ability_manages, except: [:show, :destroy]
end
