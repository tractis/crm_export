ActionController::Routing::Routes.draw do |map| 
  map.resources :exports, :collection => { :contacts => :get }
end