Rails.application.routes.draw do

	devise_for :users
	devise_scope :user do
  	get 'user/sign_up' => 'devise/registrations#new'
  end

  get 'home/about' => "root#about"



	root 'root#top'
	

  resources :books

  resources :users, only: [:index, :show, :create, :edit, :destroy, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
