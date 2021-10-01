if Rails.env === 'production'
  Rails.application.config.session_store :cookie_store, key: '_drill-app-api', domain: 'test.flak.jp'
else
  Rails.application.config.session_store :cookie_store, key: '_drill-app-api', domain: 'test.flak.jp'
end