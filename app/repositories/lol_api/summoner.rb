module LolApi
  class Summoner < Base

    def find_by_name(name)
      client.summoner.by_name(name).first
    rescue Lol::NotFound => e
      raise NotFoundError.new("Summoner #{name} was not found in region #{region}")
    rescue Lol::InvalidAPIResponse => e
      raise InvalidResponseError.new(e)
    end

  end
end
