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
      expect(illianthe.profileIconId).to eq(539)
      expect(illianthe.revisionDate).to eq(1386988105000)
      expect(illianthe.revisionDateStr).to eq("12/14/2013 02:28 AM UTC")
      expect(illianthe.summonerLevel).to eq(30)
      expect(illianthe.region).to eq("na")
    end
  end
end