module LoLBase
  class ProfileIcon
    attr_reader :id

    def initialize(id, summoner)
      @id = id
      @summoner = summoner
    end
  end
end