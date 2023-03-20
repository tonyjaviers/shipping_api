Rails.application.routes.draw do
  resources :products, except: [:new, :edit] 
  get 'find_by_dimensions' => 'products#find_by_dimensions'
  
  # get '/products/:length/:width/:height/:weight', to: 'products#find_by_dimensions', as: 'find_by_dimensions'

end


