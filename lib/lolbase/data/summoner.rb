require "json"

module LoLBase
  class Summoner
    attr_reader :id, :name, :profileIconId, :revisionDate, :revisionDateStr, :summonerLevel, :region

    # Input
    # - params - A hash containing either a summoner name or ID and the region that they belong to
    #   (e.g. { id: 123, region: "na" })
    # - connection - Current connection to the Riot API
    #
    # Effects: Calls the Riot API to retrieve data for the given summoner
    #
    # Output: Returns the Summoner class for further chaining
    def initialize(params, connection)
      @id = params[:id]
      @name = params[:name]
      @region = params[:region]
      @connection = connection

      response =
        if !@id.nil?
          # Find summoner by ID
          connection.get "/api/lol/#{@region}/v#{LoLBase.config.version_summoner}/summoner/#{@id}"
        else
          # Find summoner by name
          connection.get "/api/lol/#{@region}/v#{LoLBase.config.version_summoner}/summoner/by-name/#{@name}"
        end

      # Populate object with response data
      data = JSON.parse(response)
      @id = data["id"]
      @name = data["name"]
      @profileIconId = data["profileIconId"]
      @revisionDate = data["revisionDate"]
      @revisionDateStr = data["revisionDateStr"]
      @summonerLevel = data["summonerLevel"]

      self
    end
  end
end