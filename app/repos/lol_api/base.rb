module LolApi
  class Base

    class << self
      attr_accessor :api_key
    end

    attr_accessor :region

    def initialize(region)
      self.region = region
    end

    def client
      ::Lol::Client.new(LolApi::Base.api_key, { region: region })
    end

  end
end
