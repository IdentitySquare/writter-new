require 'lograge/sql/extension'

Rails.application.configure do
  config.lograge.enabled = true
end

Logstop.guard(Rails.logger)