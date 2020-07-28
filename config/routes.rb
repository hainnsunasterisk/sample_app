Rails.application.routes.draw do
  get 'test_i18n/index'
  scope "(:locale)", locale: /en|vi/ do
  end
end


