require "json"

module LoLBase
  class Summoner
    attr_reader :id, :name, :last_modified, :level, :region

    # Input
    # - params - A hash containing either a summoner name or ID, the region that they belong to,
    #   and whether to preload the object with Riot's data (e.g. { id: 123, region: "na", preload: false })
    # - connection - Current connection to the Riot API
    #
    # Output: Returns a Summoner object for further chaining
    def initialize(params, connection)
      @id = params[:id]
      @name = params[:name]
      @region = params[:region]
      @connection = connection

      load unless params[:preload] == false

      self
    end

    def load
      response =
        if !@id.nil?
          # Find summoner by ID
          @connection.get "/api/lol/#{@region}/v#{LoLBase.config.version_summoner}/summoner/#{@id}"
        else
          # Find summoner by name
          @connection.get "/api/lol/#{@region}/v#{LoLBase.config.version_summoner}/summoner/by-name/#{@name}"
        end

      # Populate object with response data
      data = JSON.parse(response)
      @id = data["id"]
      @name = data["name"]
      @profile_icon = ProfileIcon.new data["profileIconId"], self
      @last_modified = Time.at(data["revisionDate"] / 1000)
      @level = data["summonerLevel"]
    end

    def profile_icon
      return @profile_icon || ProfileIcon.new(nil, self)
    end

    # Return stats for the given summoner. Syntactic sugar for retrieving summary
    # or ranked stats.
    def stats(type = nil)
      @stats ||= Stats.new(self, @connection)

      if type == :summary
        return @stats.summary
      elsif type == :ranked
        return @stats.ranked
      else
        return @stats
      end
    end
  end
end