require 'actionmailer_with_request'

ActionController::Base.send :include, ActionMailerWithRequest::ControllerMixin
ActionMailer::Base.send :include, ActionMailerWithRequest::MailerMonkeyPatch

Rails.logger.info("** ActionMailerWithRequest: initialized properly") if defined?(Rails)
