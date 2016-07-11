Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :games, only: ['index', 'show', 'destroy'] do

    member do
      post :lock
      delete :lock, action: :unlock
    end

    resource :outcome, only: ['create'] do
      # resources :team_outcomes -- not a separate route; subsumed inside Outcome
    end
  end

  resources :players do
    resource :piece, only: ['create', 'update']
  end

end
