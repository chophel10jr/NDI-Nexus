Rails.application.routes.draw do
  post "create_proof_request", to: "verifier#create_proof_request"

  resources :verifiable_credentials, only: [ :create ] do
    collection do
      get :fetch
    end
  end
end
