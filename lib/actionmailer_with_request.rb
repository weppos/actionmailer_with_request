module ActionMailerWithRequest

  module ControllerMixin

    def self.included(base)
      base.class_eval do
        before_filter :store_request
      end
    end

    def store_request
      Thread.current[:request] = request
    end

  end

  module MailerDefaults

    def self.included(base)
      base.singleton_class.class_eval do
        def default_url_options_with_current_request(options=nil)
          host = Thread.current[:request].try(:host)
          port = Thread.current[:request].try(:port)
          defaults = {}
          defaults[:host] = host if host
          defaults[:port] = port if port and port != 80
          default_url_options_without_current_request(options).merge(defaults)
        end
        alias_method_chain :default_url_options, :current_request

        def default_with_current_request(value=nil)
          domain = Thread.current[:request].try(:domain)
          defaults = {}
          defaults[:to] = "admin@#{domain}"
          defaults[:from] = "no-reply@#{domain}"
          defaults.merge(default_without_current_request(value))
        end
        alias_method_chain :default, :current_request
      end
    end
  end

  class Railtie < Rails::Railtie
    initializer 'actionmailer.with_request.mixin' do
      ActionController::Base.send :include, ActionMailerWithRequest::ControllerMixin
      ActionMailer::Base.send :include, ActionMailerWithRequest::MailerDefaults
    end
  end
end
