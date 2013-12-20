require "json"

module LoLBase
  class Stats
    # Input
    # - summoner - A Summoner object
    # - connection - Current connection to Riot's API
    #
    # Output: Returns a Stats object for further chaining
    def initialize(summoner, connection)
      @summoner = summoner
      @connection = connection
      self
    end

    def summary(season = LoLBase.config.current_season)
      response = @connection.get(
        "/api/lol/#{@summoner.region}/v#{LoLBase.config.version_stats}/stats/by-summoner/#{@summoner.id}/summary",
        { query: { season: "SEASON#{season}" } }
      )
      JSON.parse response
    end

    def ranked(season = LoLBase.config.current_season)
      response = @connection.get(
        "/api/lol/#{@summoner.region}/v#{LoLBase.config.version_stats}/stats/by-summoner/#{@summoner.id}/ranked",
        { query: { season: "SEASON#{season}" } }
      )
      JSON.parse response
    end
  end
end