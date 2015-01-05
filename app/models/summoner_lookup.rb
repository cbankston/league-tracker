class SummonerLookup
  include ActiveModel::Model

  attr_accessor :name, :region

  validates :name, presence: true
  validates :region, presence: true
end
