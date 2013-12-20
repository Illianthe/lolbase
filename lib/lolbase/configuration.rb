module LoLBase
  class << self
    attr_reader :config

    def configure(&block)
      yield @config ||= Configuration.new
    end
  end

  class Configuration
    attr_accessor :default_region,
                  :default_key,
                  :version_champion,
                  :version_game,
                  :version_league,
                  :version_stats,
                  :version_summoner,
                  :version_team,
                  :current_season
  end

  # Default config values
  configure do |config|
    config.default_region = "na"

    config.version_champion = "1.1"
    config.version_game = "1.2"
    config.version_league = "2.2"
    config.version_stats = "1.2"
    config.version_summoner = "1.2"
    config.version_team = "2.2"
    
    config.current_season = "3"
  end
end