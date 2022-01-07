Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace "api" do
    namespace "v_desktop" do
      scope "subjects" do
        get 'index', to: 'subjects#index'
        get 'show/:id', to: 'subjects#show'
        post 'create', to: 'subjects#create'
        patch 'update/:id', to: 'subjects#update'
        delete 'delete/:id', to: 'subjects#delete'
        get 'my_times/:id', to: "subjects#my_times"
      end
    end
  end
end
