require 'actionmailer_with_request'

ActionController::Base.send(:include, ActionMailerWithRequest::ControllerMixin)
ActionMailer::Base.send(:include, ActionMailerWithRequest::MailerDefaultUrlOptions)


RAILS_DEFAULT_LOGGER.info("** ActionMailerWithRequest: initialized properly")
