ActionController::Routing::Routes.draw do |map| 
  map.resources :exports, :collection => { :contacts => :get }, :member => { :download => :get }
end