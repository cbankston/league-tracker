module LolApi
  class Base

    class << self
      attr_accessor :api_key
    end

    def client(region = :na)
      ::Lol::Client.new(LolApi::Base.api_key, { region: region })
    end

  end
end
