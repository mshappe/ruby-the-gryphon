unless Rails.env.production?
    BetterErrors::Middleware.allow_ip! '0.0.0.0/0'
end