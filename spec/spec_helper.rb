require "webmock/rspec"
require "lolbase"

RSpec.configure do |config|
  config.before(:each) do
    stub_info = [
      # Summoner lookup
      {
        file: File.read(File.expand_path("../json/summoner/1.2/summoner.json", __FILE__)),
        url: "https://prod.api.pvp.net/api/lol/na/v1.2/summoner/by-name/illianthe?api_key=random-key"
      },
      {
        file: File.read(File.expand_path("../json/summoner/1.2/summoner.json", __FILE__)),
        url: "https://prod.api.pvp.net/api/lol/na/v1.2/summoner/19578577?api_key=random-key"
      },
      # Summary stats
      {
        file: File.read(File.expand_path("../json/stats/1.2/summary_s3.json", __FILE__)),
        url: "https://prod.api.pvp.net/api/lol/na/v1.2/stats/by-summoner/19578577/summary?api_key=random-key&season=SEASON3"
      },
      # Ranked stats
      {
        file: File.read(File.expand_path("../json/stats/1.2/ranked_s3.json", __FILE__)),
        url: "https://prod.api.pvp.net/api/lol/na/v1.2/stats/by-summoner/19578577/ranked?api_key=random-key&season=SEASON3"
      },
      # Champion lookup
      {
        file: File.read(File.expand_path("../json/champion/1.1/champions.json", __FILE__)),
        url: "https://prod.api.pvp.net/api/lol/na/v1.1/champion?api_key=random-key"
      }
    ]

    stub_info.each do |stub|
      stub_request(:get, stub[:url]).to_return(status: 200, body: stub[:file])
    end
  end
end