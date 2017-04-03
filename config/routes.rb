Rails.application.routes.draw do
  devise_for :users
resources :jobs do
  collection do
  get :search
  end
  resources :resumes
end

resources :jobs do
put :favorite, on: :member
resources :favorite do
 end
end

 namespace :admin do
   resources :jobs do
     member do
       post :publish
       post :hide
     end
resources :resumes
   end
 end
root 'welcome#index'
end
