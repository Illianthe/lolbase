module LoLBase
  class ChampionList
    def initialize(region, connection)
      @champions = []

      data = JSON.parse connection.get("/api/lol/#{region}/v1.1/champion")
      data["champions"].each do |c|
        @champions << Champion.new(c)
      end

      self
    end

    def find(criteria = {})
      if criteria[:id]
        return @champions.select { |champ| champ.id == criteria[:id] }.first
      elsif criteria[:name]
        return @champions.select { |champ| champ.name == criteria[:name] }.first
      elsif criteria[:free_to_play]
        return @champions.select { |champ| champ.f2p? == criteria[:free_to_play] }
      end

      nil
    end

    def all
      return @champions
    end
  end

  class Champion
    attr_reader :id, :name, :stats, :status

    def initialize(data)
      @data = data
      @id = data["id"]
      @name = data["name"]
    end

    def f2p?
      @data["freeToPlay"]
    end

    def status
      {
        enabled: @data["active"],
        ranked_enabled: @data["rankedPlayEnabled"],
        bot_enabled: @data["botEnabled"],
        coop_bot_enabled: @data["botMmEnabled"]
      }
    end

    def stats
      {
        attack_power: @data["attackRank"],
        defense_power: @data["defenseRank"],
        ability_power: @data["magicRank"],
        difficulty: @data["difficultyRank"]
      }
    end
  end
end