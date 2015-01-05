class ImportSummoner

  attr_reader :summoner

  def initialize(params)
    raise ArgumentError.new("Missing required parameter. :id or :name is required.") unless params[:id] || params[:name]
    raise ArgumentError.new("Missing required parameter :region.") unless params[:region]

    self.id = params[:id]
    self.name = params[:name]
    self.region = params[:region]
  end

  def run
    api_summoner = lookup_summoner
    self.summoner = Summoner.find_or_initialize_by(id: "#{region}-#{api_summoner.id}")

    summoner.attributes = transform(api_summoner)
    summoner.save!
  end

  private

  attr_accessor :id, :name, :region
  attr_writer :summoner

  def lookup_summoner
    if id
      repo.new(region).find(id)
    else name
      repo.new(region).find_by_name(name)
    end
  end

  def transform(summoner)
    {
      region: region,
      name: summoner.name,
      profile_icon_id: summoner.profile_icon_id,
      summoner_level: summoner.summoner_level,
      revision_date: summoner.revision_date
    }
  end

  def repo
    LolApi::Summoner
  end

end
