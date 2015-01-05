class SummonerTrackerForm
  include ActiveModel::Model

  delegate :name, :region, :valid?, to: :summoner_lookup

  def initialize(params = {})
    super({})
    self.user = params.fetch(:user)
    self.summoner_lookup = SummonerLookup.new(summoner_lookup_params(params))
  end

  def errors
    if summoner_lookup.errors.present?
      summoner_lookup.errors
    else
      super()
    end
  end

  def save
    return false unless valid?

    self.summoner = find_or_import_summoner

    summoner.present? && track_summoner
  end

  private

  attr_accessor :summoner_lookup, :summoner, :user

  def find_or_import_summoner
    SummonerRepo.new(summoner_lookup.region).find_or_import_by_name(summoner_lookup.name)
  rescue NotFoundError => e
    errors.add(:name, I18n.t('errors.messages.summoner_not_found'))
    nil
  end

  def track_summoner
    TrackedSummonerRepo.new.track_summoner(user, summoner)
  end

  def summoner_lookup_params(params)
    params.slice(:name, :region)
  end

end
