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
      fetch_stats(:summary, season)
    end

    def ranked(season = LoLBase.config.current_season)
      fetch_stats(:ranked, season)
    end

  private

    def fetch_stats(type, season)
      response = @connection.get(
        "/api/lol/#{@summoner.region}/v#{LoLBase.config.version_stats}/stats/by-summoner/#{@summoner.id}/#{type}",
        { query: { season: "SEASON#{season}" } }
      )

      if type == :summary
        return SummaryStats.new response
      elsif type == :ranked
        return RankedStats.new response
      end
    end
  end

  class SummaryStats
    class Summary
      attr_reader :name, :last_modified, :stats

      def initialize(params)
        @name = params[:name]
        @last_modified = params[:last_modified]
        @stats = params[:stats]
      end
    end

    def initialize(data)
      @data = data
      parse data
      self
    end

    def raw_json
      @data
    end

    def find(criteria = {})
      raise InvalidArgumentError if criteria.class != Hash
      if criteria[:name]
        return @parsed_data.select { |item| item.name == criteria[:name] }.first
      end
      nil
    end

    def all
      return @parsed_data
    end

  private

    def parse(data)
      @parsed_data = []

      data = JSON.parse data
      data["playerStatSummaries"].each do |s|
        @parsed_data <<
          Summary.new({
            name: s["playerStatSummaryType"],
            last_modified: Time.at(s["modifyDate"] / 1000),
            stats: s["aggregatedStats"].merge!({ "wins" => s["wins"], "losses" => s["losses"] })
          })
      end
    end
  end

  class RankedStats
    attr_reader :last_modified, :overall

    class Champion
      attr_reader :id, :stats

      def initialize(params)
        @id = params[:id]
        @stats = params[:stats]
      end
    end

    def initialize(data)
      @data = data
      parse data
      self
    end

    def raw_json
      @data
    end

    def find(criteria = {})
      raise InvalidArgumentError if criteria.class != Hash
      if criteria[:champion_id]
        return @parsed_data.select { |item| item.id == criteria[:champion_id] }.first
      end
      nil
    end

    def all
      return @parsed_data
    end

  private

    def parse(data)
      @parsed_data = []

      data = JSON.parse data
      @last_modified = Time.at(data["modifyDate"] / 1000)
      data["champions"].each do |c|
        # Overall stats are combined with champion stats in the raw JSON data -
        # split it out
        if c["id"] == 0
          @overall = c["stats"]
        else
          @parsed_data <<
            Champion.new({
              id: c["id"],
              stats: c["stats"]
            })
        end
      end
    end
  end
end