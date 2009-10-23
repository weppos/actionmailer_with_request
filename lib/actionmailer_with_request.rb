module ActionMailerWithRequest

  class OptionsProxy

    mattr_accessor :defaults

    self.defaults = lambda do
      host = Thread.current[:request].try(:host) || "www.example.com"
      port = Thread.current[:request].try(:port) || 80

      returning({}) do |params|
        params[:host] = host
        params[:port] = port if port != 80
      end
    end

    def initialize(params = {})
      @params = params
    end

    def method_missing(name, *args, &block)
      @params.merge(defaults.call).send(name, *args, &block)
    end

  end


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

  module MailerMonkeyPatch

    def self.included(base)
      base.default_url_options = ActionMailerWithRequest::OptionsProxy.new(base.default_url_options)
    end

  end

end