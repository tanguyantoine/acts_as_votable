$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'acts_as_votable'
require 'mongoid'
Mongoid.load!("./mongoid.yml", 'test')
Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

# ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

# ActiveRecord::Schema.define(:version => 1) do
  # create_table :votes do |t|
  #   t.references :votable, :polymorphic => true
  #   t.references :voter, :polymorphic => true

  #   t.boolean :vote_flag
  #   t.string :vote_scope
  #   t.integer :vote_weight

  #   t.timestamps
  # end

  # add_index :votes, [:votable_id, :votable_type]
  # add_index :votes, [:voter_id, :voter_type]
  # add_index :votes, [:voter_id, :voter_type, :vote_scope]
  # add_index :votes, [:votable_id, :votable_type, :vote_scope]

  # create_table :voters do |t|
  #   t.string :name
  # end

  # create_table :not_voters do |t|
  #   t.string :name
  # end

  # create_table :votables do |t|
  #   t.string :name
  # end

  # create_table :votable_voters do |t|
  #   t.string :name
  # end

  # create_table :sti_votables do |t|
  #   t.string :name
  #   t.string :type
  # end

  # create_table :sti_not_votables do |t|
  #   t.string :name
  #   t.string :type
  # end

  # create_table :not_votables do |t|
  #   t.string :name
  # end

  # create_table :votable_caches do |t|
  #   t.string :name
  #   t.integer :cached_votes_total
  #   t.integer :cached_votes_score
  #   t.integer :cached_votes_up
  #   t.integer :cached_votes_down
  #   t.integer :cached_weighted_score

  #   t.integer :cached_scoped_test_votes_total
  #   t.integer :cached_scoped_test_votes_score
  #   t.integer :cached_scoped_test_votes_up
  #   t.integer :cached_scoped_test_votes_down
  #   t.integer :cached_scoped_weighted_score
  # end

# end


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
  models.each do |model|
    model.delete_all
  end
end
