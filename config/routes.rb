Rails.application.routes.draw do
  get 'grid', to: 'games#grid'
  get 'results', to: 'games#results'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
