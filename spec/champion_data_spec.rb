require "spec_helper"

describe LoLBase::Champion do
  before do
    @connection = LoLBase.new "random-key"
  end

  it "should retrieve a list of champions when requested" do
    champions = @connection.champions.all
    expect(champions.count).to eq(117)
  end

  it "should return details of a specific champion (by ID)" do
    champion = @connection.champions.find(id: 99)
    expect(champion.name).to eq("Lux")
    expect(champion.f2p?).to eq(false)
    expect(champion.status[:enabled]).to eq(true)
    expect(champion.status[:ranked_enabled]).to eq(true)
    expect(champion.status[:bot_enabled]).to eq(true)
    expect(champion.status[:coop_bot_enabled]).to eq(true)
    expect(champion.stats[:attack_power]).to eq(2)
    expect(champion.stats[:defense_power]).to eq(4)
    expect(champion.stats[:ability_power]).to eq(9)
    expect(champion.stats[:difficulty]).to eq(6)
  end

  it "should return details of a specific champion (by name)" do
    champion = @connection.champions.find(name: "Lux")
    expect(champion.id).to eq(99)
  end

  it "should return a list of all currently free to play champions" do
    f2p = @connection.champions.find(free_to_play: true)
    expect(f2p.count).to eq(10)
  end

  it "should throw an error when trying to find a champion with invalid parameters" do
    expect { @connection.champions.find("free") }.to raise_error(LoLBase::InvalidArgumentError)
  end
end