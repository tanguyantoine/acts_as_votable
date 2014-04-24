require 'acts_as_votable/helpers/words'

module ActsAsVotable
  class Vote
    include Mongoid::Document
    include Mongoid::Timestamps
    include Helpers::Words

    #fields
    field :vote_flag, type: Boolean
    field :vote_scope, type: String
    field :vote_weight, type: Integer

    #associations
    belongs_to :voteable, polymorphic: true, index: true
    belongs_to :voter, polymorphic: true, index: true

    # indexes
    index({ votable_id: 1, votable_type: 1 })
    index({ voter_id: 1, voter_type: 1 })
    index({ voter_id: 1, voter_type: 1, vote_scope: 1 })
    index({ votable_id: 1, votable_type: 1, vote_scope: 1 })
    if true
      field :cached_votes_total, type: Integer, default: 0
      field :cached_votes_score, type: Integer, default: 0
      field :cached_votes_up, type: Integer, default: 0
      field :cached_votes_down, type: Integer, default: 0
      field :cached_weighted_score, type: Integer, default: 0

      index({ cached_votes_total: 1 })
      index({ cached_votes_score: 1 })
      index({ cached_votes_up: 1 })
      index({ cached_votes_down: 1 })
      index({ cached_weighted_score: 1 })

    end

    belongs_to :votable, :polymorphic => true
    belongs_to :voter, :polymorphic => true

    scope :up, lambda{ where(:vote_flag => true) }
    scope :down, lambda{ where(:vote_flag => false) }
    scope :for_type, lambda{ |klass| where(:votable_type => klass) }
    scope :by_type,  lambda{ |klass| where(:voter_type => klass) }

    validates_presence_of :votable_id
    validates_presence_of :voter_id

  end

end

