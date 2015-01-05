class TrackedSummoner
  include Mongoid::Document

  embedded_in :user

  belongs_to :summoner
end
