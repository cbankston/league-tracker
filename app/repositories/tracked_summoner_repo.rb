class TrackedSummonerRepo

  def all(user)
    user.tracked_summoners
  end

  def track_summoner(user, summoner)
    return true if tracking_summoner?(user, summoner)

    user.tracked_summoners << TrackedSummoner.new(summoner: summoner)
  end

  def tracking_summoner?(user, summoner)
    user.tracked_summoners.any? { |ts| ts.summoner_id == summoner.id }
  end

end
