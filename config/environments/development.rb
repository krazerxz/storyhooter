Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = false
  config.active_support.deprecation = :log
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  config.action_controller.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {host: "localhost:3000"}
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    user_name: Rails.application.secrets["gmail_username"],
    password: Rails.application.secrets["gmail_password"],
    authentication: "plain",
    enable_starttls_auto: true
  }
end
Rails.application.config.middleware.use ExceptionNotification::Rack,
                                        email: {
                                          email_prefix: "[SH Exception] ",
                                          sender_address: %("notifier" <"#{Rails.application.secrets['exception_email_address']}">),
                                          exception_recipients: [Rails.application.secrets["exception_email_address"].to_s]
                                        }
