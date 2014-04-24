require 'mongoid'
require 'active_support/inflector'

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsVotable
end

require 'acts_as_votable/votable'
require 'acts_as_votable/voter'
require 'acts_as_votable/vote'

require 'acts_as_votable/extenders/controller'
ActiveSupport.on_load(:action_controller) do
  include ActsAsVotable::Extenders::Controller
end