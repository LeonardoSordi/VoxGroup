Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3001'
    resource '*',
             headers: :any,
             methods: [:get, :post, :update, :destroy, :edit, :show],
             credentials: true
  end
end