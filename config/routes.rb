Rails.application.routes.draw do
  root 'domains#index'
  get 'domains', to: 'domains#index'
  get 'relevant_domains', to: 'domains#relevant'
  get 'domain_details', to: 'domains#details'
  get 'goto_plesk', to: 'api#goto_plesk'
end
