if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_drill-app-api', domain: 'dev.ds-drill.com'
else
  Rails.application.config.session_store :cookie_store, key: '_drill-app-api', domain: 'test.ds-drill.com'
end