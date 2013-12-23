require "spec_helper"

describe LoLBase::Stats do
  before do
    @connection = LoLBase.new "random-key"
    @illianthe = @connection.summoner("illianthe")
  end

  it "should return a summoner's stats summary for a given game type when requested" do
    coop = @illianthe.stats.summary.find(name: "CoopVsAI")
    expect(coop.stats["wins"]).to eq(1177)
    expect(coop.last_modified).to eq(Time.at(1302601118))

    aram = @illianthe.stats.summary.find(name: "AramUnranked5x5")
    expect(aram.stats["wins"]).to eq(209)
    expect(aram.last_modified).to eq(Time.at(1387446729))
  end

  it "should return a summoner's stats summary for all game types when requested" do
    summary = @illianthe.stats.summary.all
    expect(summary.count).to eq(7)
  end

  it "should return a summoner's ranked stats for a given champion when requested" do
    ranked = @illianthe.stats.ranked
    expect(ranked.last_modified).to eq(Time.at(1384212356))

    lux = ranked.find(champion_id: 99)
    expect(lux.stats["totalSessionsPlayed"]).to eq(17)
  end

  it "should return a summoner's ranked stats for all champions when requested" do
    ranked = @illianthe.stats.ranked.all
    expect(ranked.count).to eq(11)
  end

  it "should return a summoner's overall ranked stats" do
    overall = @illianthe.stats.ranked.overall
    expect(overall["totalDamageTaken"]).to eq(583858)
  end
end