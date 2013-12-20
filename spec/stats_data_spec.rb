require "spec_helper"

describe LoLBase::Stats do
  before do
    @connection = LoLBase.new "random-key"
  end

  it "should return a summoner's stats summary when requested" do
    summary = @connection.summoner("illianthe").stats.summary
    expect(summary["playerStatSummaries"].count).to eq(7)
  end

  it "should return a summoner's ranked stats when requested" do
    ranked = @connection.summoner("illianthe").stats.ranked
    expect(ranked["modifyDate"]).to eq(1384212356000)
  end
end