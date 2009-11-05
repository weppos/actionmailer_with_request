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
      class << base
        include Method
        alias_method_chain :default_url_options, :current_request
      end
    end
    
    module Method
      def default_url_options_with_current_request
        host = Thread.current[:request].try(:host)
        port = Thread.current[:request].try(:port)
        default = {}
        default[:host] = host if host
        default[:port] = port if port
        default_url_options_without_current_request.merge(default)
      end
    end
  end
end
