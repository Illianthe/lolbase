require 'httparty'

module LoLBase
  def self.new(key = nil)
    return Connection.new(key)
  end

  class Connection
    include HTTParty
    base_uri "https://prod.api.pvp.net"

    # Override HTTParty's get method to append the API key and to process errors returned from request
    def get(path, options = {})
      if options[:query].nil?
        options.merge!({ query: { api_key: @key } })
      else
        options[:query].merge!({ api_key: @key })
      end

      response = self.class.get path, options
      raise LoLBaseError, response.message if response.code != 200
      response.body
    end

    def initialize(key = nil)
      @key = key || LoLBase.config.default_key
      self
    end

    # Syntactic sugar: lookup summoner by name or by ID
    def summoner(identifier, region = LoLBase.config.default_region)
      if identifier.is_a? String
        return summoner_by_name(identifier, region)
      else
        return summoner_by_id(identifier, region)
      end
    end

    def summoner_by_name(name, region = LoLBase.config.default_region)
      Summoner.new({ name: name, region: region }, self)
    end

    def summoner_by_id(id, region = LoLBase.config.default_region)
      Summoner.new({ id: id, region: region }, self)
    end

    def champions(region = LoLBase.config.default_region)
      ChampionList.new(region, self)
    end
  end
end