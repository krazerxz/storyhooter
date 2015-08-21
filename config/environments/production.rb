Rails.application.configure do
  config.eager_load = true
  config.consider_all_requests_local = false
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = true
  config.assets.digest = true
  config.log_level = :debug
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.action_controller.perform_caching = true
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => "storyhooter.com" }
end
Rails.application.config.middleware.use ExceptionNotification::Rack,
                                        email: {
                                          email_prefix: '[SH Exception] ',
                                          sender_address: %("notifier" <exception.notifier@storyhooter.com>),
                                          exception_recipients: %w(exceptions.storyhooter@gmail.com)
                                        }
