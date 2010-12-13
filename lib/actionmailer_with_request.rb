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
      base.class_eval do
        # Extends ActionMailer#default_url_options capabilities
        # by merging the latest request context into the default url options.
        #
        # Returns the default url options Hash.
        def default_url_options_with_current_request(*args)
          protocol = Thread.current[:request].try(:protocol)
          host = Thread.current[:request].try(:host)
          port = Thread.current[:request].try(:port)
          defaults = {}
          defaults[:protocol] = protocol unless protocol == 'http://'
          defaults[:host] = host if host
          defaults[:port] = port if port and
            (protocol == 'http://' && port != 80) ||
            (protocol == 'https://' && port != 443)
          default_url_options_without_current_request(*args).merge(defaults)
        end

        alias_method_chain :default_url_options, :current_request
      end
    end
  end
end
