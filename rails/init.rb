require 'actionmailer_with_request'

ActionController::Base.send :include, ActionMailerWithRequest::ControllerMixin
ActionMailer::Base.send :include, ActionMailerWithRequest::MailerMonkeyPatch

RAILS_DEFAULT_LOGGER.info("** ActionMailerWithRequest: initialized properly")
