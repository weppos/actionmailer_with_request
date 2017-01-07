require_relative "actionmailer_with_request/version"

module ActionMailerWithRequest

  module RequestRecorder
    def self.included(base)
      base.class_eval do
        before_action :store_request
      end
    end

    def store_request
      Thread.current["actiondispatch.request"] = request
    end
  end

  module DefaultUrlOptionsOverride
    # Extends ActionMailer#default_url_options capabilities
    # by merging the latest request context into the default url options.
    #
    # Returns the default url options Hash.
    def default_url_options(*args)
      defaults = {}
      request  = Thread.current["actiondispatch.request"]

      if request
        host     = request.host
        port     = request.port
        protocol = request.protocol
        standard_port = request.standard_port

        defaults[:protocol] = protocol
        defaults[:host]     = host
        defaults[:port]     = port if port != standard_port
      end

      super.merge(defaults)
    end
  end

  module RequestAccess
    # Get the current request. This assists in making request-based
    # e-mail addresses. For example:
    #
    #   mail :from => "no-reply@#{request.try(:domain) || 'example.com'}", .....
    #
    # Remember if the mailer is delivered outside the context of a
    # request then this method returns nil. Hence the try(:domain)
    # as well as the fallback domain.
    def request
      Thread.current["actiondispatch.request"]
    end
  end

  class Railtie < Rails::Railtie
    initializer 'actionmailer.with_request' do
      ActionController::Base.send :include, ActionMailerWithRequest::RequestRecorder
      ActionMailer::Base.prepend ActionMailerWithRequest::DefaultUrlOptionsOverride
      ActionMailer::Base.include ActionMailerWithRequest::RequestAccess
    end
  end
end
