# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://test.flak.jp:3000', 'localhost:3000', '127.0.0.1:3000'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end