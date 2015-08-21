Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = false
  config.active_support.deprecation = :log
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  config.action_controller.perform_caching = false
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true
end
Rails.application.config.middleware.use ExceptionNotification::Rack,
                                        email: {
                                          email_prefix: '[SH Exception] ',
                                          sender_address: %("notifier" <exception.notifier@storyhooter.com>),
                                          exception_recipients: %w(exceptions.storyhooter@gmail.com)
                                        }
