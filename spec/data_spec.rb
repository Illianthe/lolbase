require "spec_helper"

describe "LoLBase Data" do
  before do
    @connection = LoLBase.new "random-key"
  end

  context "Summoner" do
    it "should return summoner data when requested" do
      file = File.read(File.expand_path("../json/summoner.json", __FILE__))
      stub_request(:get, "https://prod.api.pvp.net/api/lol/na/v1.1/summoner/by-name/illianthe?api_key=random-key").to_return(status: 200, body: file)
      
      illianthe = @connection.summoner("illianthe")
      expect(illianthe.id).to eq(19578577)
      expect(illianthe.name).to eq("Illianthe")
      expect(illianthe.profile_icon.id).to eq(539)
      expect(illianthe.last_modified).to eq(Time.at(1386988105))
      expect(illianthe.level).to eq(30)
      expect(illianthe.region).to eq("na")
    end
  end
end