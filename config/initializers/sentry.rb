Sentry.init do |config|
  config.dsn = ENV["SENTRY_TOKEN"]
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end

  config.environment = Rails.env

  config.enabled_environments = ["production", "development"]
end
