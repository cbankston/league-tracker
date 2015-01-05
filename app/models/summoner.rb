class Summoner
  include Mongoid::Document

  field :region, type: String, default: ""
  field :name, type: String, default: ""
  field :profile_icon_id, type: Integer
  field :summoner_level, type: Integer, default: 0
  field :revision_date, type: DateTime

end
