Rails.application.routes.draw do
  devise_for :users

  # Root path based on user role
  authenticated :user, ->(u) { u.doctor? } do
    root to: "doctor/dashboard#index", as: :doctor_root
  end

  authenticated :user, ->(u) { u.receptionist? } do
    root to: "receptionist/dashboard#index", as: :receptionist_root
  end

  root to: "home#index"
  # root to: 'devise/sessions#new'

  namespace :doctor do
  root to: "dashboard#index", as: :dashboard # This creates doctor_dashboard_path
  resources :patients, only: [ :index, :show ] do
    collection do
      post :create_sample_data
    end
  end
  end

  namespace :receptionist do
  root to: "dashboard#index", as: :dashboard # This creates receptionist_dashboard_path
  resources :patients
  end
end
