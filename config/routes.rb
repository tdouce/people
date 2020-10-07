Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :records, only: [:create] do
    get ':sort', action: :index, as: :record_sort
  end
end
