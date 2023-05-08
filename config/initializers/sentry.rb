Sentry.init do |config|
  config.dsn = 'https://30308ac26cfd4d50ad9b66155f5b7add@o1339088.ingest.sentry.io/4505034741186560'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end