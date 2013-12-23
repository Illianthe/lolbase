require "spec_helper"

describe LoLBase::Summoner do
  before do
    @connection = LoLBase.new "random-key"
    @illianthe = @connection.summoner("illianthe")
  end

  it "should return basic summoner data" do
    expect(@illianthe.id).to eq(19578577)
    expect(@illianthe.name).to eq("Illianthe")
    expect(@illianthe.region).to eq("na")
    expect(@illianthe.level).to eq(30)
    expect(@illianthe.last_modified).to eq(Time.at(1387446729))
  end

  it "should return profile icon data" do
    expect(@illianthe.profile_icon.class).to eq(LoLBase::ProfileIcon) 
    expect(@illianthe.profile_icon.id).to eq(539)
  end

  context "Stats" do
    it "should return a generic Stats object when called without arguments" do
      expect(@illianthe.stats.class).to eq(LoLBase::Stats)
    end

    it "should return SummaryStats when called with :summary" do
      expect(@illianthe.stats(:summary).class).to eq(LoLBase::SummaryStats)
    end

    it "should return RankedStats when called with :rank" do
      expect(@illianthe.stats(:ranked).class).to eq(LoLBase::RankedStats)
    end
  end
end