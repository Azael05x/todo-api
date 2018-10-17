Rails.application.routes.draw do
  scope 'api' do
    namespace 'v1' do
      resources :tasks
    end
  end
end
