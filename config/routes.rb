Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions' }
resources :jobs do
  collection do
  get :search
  get :city
  end
  resources :resumes
end

resources :jobs do
put :favorite, on: :member
resources :favorite do
 end
end

namespace :account do
  resources :users
  resources :jobs
end

resources :jobs do
    member do
      post :upvote
     post :downvote
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
