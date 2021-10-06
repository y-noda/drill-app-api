if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_drill-app-api', domain: '40.74.136.199'
else
  Rails.application.config.session_store :cookie_store, key: '_drill-app-api', domain: '40.74.136.199'
end