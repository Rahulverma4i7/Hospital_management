Rails.application.routes.draw do
  devise_for :users

  # Root path based on user role
  authenticated :user, ->(u) { u.doctor? } do
    root to: "doctor/dashboard#index", as: :doctor_root
  end

  authenticated :user, ->(u) { u.receptionist? } do
    root to: "receptionist/dashboard#index", as: :receptionist_root
  end

  unauthenticated do
    root to: "home#index"
  end

  namespace :doctor do
    get "patient_trends", to: "dashboard#patient_trends"
    resources :patients, only: [ :index, :show ] do
      collection do
        post :create_sample_data
      end
    end
  end

  namespace :receptionist do
    resources :patients
  end
end
