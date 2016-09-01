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
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: Rails.application.secrets['fqdn'] }
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    user_name: Rails.application.secrets['gmail_username'],
    password: Rails.application.secrets['gmail_password'],
    authentication: 'plain',
    enable_starttls_auto: true
  }
end
Rails.application.config.middleware.use ExceptionNotification::Rack,
                                        email: {
                                          email_prefix: '[SH Exception] ',
                                          sender_address: %("notifier" <"#{Rails.application.secrets['exception_email_address']}">),
                                          exception_recipients: ["#{Rails.application.secrets['exception_email_address']}"]
                                        }
