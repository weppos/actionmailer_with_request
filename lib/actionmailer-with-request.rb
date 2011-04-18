# This file is required for BC with the existing
# "actionmailer-with-request" Gem. When Ruby (the Rails process) loads
# the library, it attempts to require a file called with the same name
# of the Gem. But because the Gem file is called with underscores,
# it won't be loaded.
#
# The choices were:
#
# 1. rename the existing Gem
# 2. add this hack
#
require 'actionmailer_with_request'
