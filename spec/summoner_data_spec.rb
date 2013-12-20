require "spec_helper"

describe LoLBase::Summoner do
  before do
    @connection = LoLBase.new "random-key"
  end

  it "should return basic summoner data when requested" do
    illianthe = @connection.summoner("illianthe")

    expect(illianthe.id).to eq(19578577)
    expect(illianthe.name).to eq("Illianthe")
    expect(illianthe.region).to eq("na")
    expect(illianthe.level).to eq(30)
    expect(illianthe.last_modified).to eq(Time.at(1387446729))
    
    expect(illianthe.profile_icon.id).to eq(539)
  end
end