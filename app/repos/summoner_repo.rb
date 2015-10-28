class SummonerRepo
  attr_accessor :region

  def initialize(region)
    self.region = region
  end

  def find_or_import_by_name(name)
    Summoner.find_by({ region: region, name: name })
  rescue Mongoid::Errors::DocumentNotFound => e
    import_by_name(name)
  end

  private

  def import_by_name(name)
    importer = ImportSummoner.new({ name: name, region: region })
    importer.run

    importer.summoner
  end

end
