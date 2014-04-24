require 'acts_as_votable'
require 'spec_helper'

describe ActsAsVotable::Votable do
  it "should not be votable" do
    NotVotable.new.should_not respond_to(:votable?)
  end

  it "should be votable" do
    Votable.new.should respond_to(:votable?)
  end

  it_behaves_like "a votable_model" do
    # TODO Replace with factories
    let (:voter) { Voter.create(:name =>'i can vote!') }
    let (:voter2) { Voter.create(:name => 'a new person') }
    let (:votable) { Votable.create(:name =>'a voting model') }
    let (:votable_cache) { VotableCache.create(:name => 'voting model with cache') }
  end
end
