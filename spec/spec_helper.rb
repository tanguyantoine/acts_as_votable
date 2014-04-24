$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'acts_as_votable'
require 'mongoid'
Mongoid.load!("./mongoid.yml", 'test')
Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

class Voter
  include Mongoid::Document
  include ActsAsVotable::Voter

  field :name
  
end

class NotVoter
  include Mongoid::Document

  field :name
end

class Votable
  include Mongoid::Document
  include ActsAsVotable::Votable

  field :name
  
  validates_presence_of :name
end

class VotableVoter
  include Mongoid::Document
  include ActsAsVotable::Votable
  include ActsAsVotable::Voter

  field :name
end

class StiVotable
  include Mongoid::Document
  include ActsAsVotable::Votable
  field :name

end

class ChildOfStiVotable < StiVotable
end

class StiNotVotable
  include Mongoid::Document

  field :name
  validates_presence_of :name
end

class VotableChildOfStiNotVotable < StiNotVotable
  include ActsAsVotable::Votable

end

class NotVotable
  include Mongoid::Document
  field :name
end

class VotableCache
  include Mongoid::Document
  include ActsAsVotable::Votable
  field :cached_scoped_test_votes_total, type: Integer
  field :cached_scoped_test_votes_score, type: Integer
  field :cached_scoped_test_votes_up, type: Integer
  field :cached_scoped_test_votes_down, type: Integer
  field :cached_scoped_weighted_score, type: Integer
  field :name
  validates_presence_of :name
end

class ABoringClass
  def self.hw
    'hello world'
  end
end


def clean_database
  models = [ActsAsVotable::Vote, Voter, NotVoter, Votable, NotVotable, VotableCache]
  #Mongoid::Tasks::Database.create_indexes models
  models.each do |model|
    model.delete_all
  end
end
