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

  module MailerDefaultUrlOptions

    def self.included(base)
      base.class_eval <<-RUBY, __FILE__, __LINE__ + 1
        # Extends ActionMailer#default_url_options capabilities
        # by merging the latest request context into the default url options.
        #
        # Returns the default url options Hash.
        def default_url_options_with_current_request(*args)
          defaults = {}
          request  = Thread.current[:request]

          if request
            host     = request.host
            port     = request.port
            protocol = request.protocol
            standard_port = request.standard_port

            defaults[:protocol] = protocol
            defaults[:host]     = host
            defaults[:port]     = port if port != standard_port
          end

          default_url_options_without_current_request(*args).merge(defaults)
        end

        alias_method_chain :default_url_options, :current_request
      RUBY
    end

    # Get the current request. This assists in making request-based
    # e-mail addresses. For example:
    #
    #   mail :from => "no-reply@#{request.try(:domain) || 'example.com'}", .....
    #
    # Remember if the mailer is delivered outside the context of a
    # request then this method returns nil. Hence the try(:domain)
    # as well as the fallback domain.
    def request
      Thread.current[:request]
    end

  end

  class Railtie < Rails::Railtie
    initializer 'actionmailer.with_request' do
      ActionController::Base.send :include, ActionMailerWithRequest::ControllerMixin
      ActionMailer::Base.send :include, ActionMailerWithRequest::MailerDefaultUrlOptions
    end
  end
end
