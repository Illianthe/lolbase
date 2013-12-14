require "spec_helper"

describe LoLBase::Connection do
  before do
    @connection = LoLBase.new "random-key"
  end

  it "rejects requests with an invalid API key" do
    stub_request(:get, "http://www.irythia.com/invalid_api_key").with(query: { api_key: "random-key" }).to_return(status: 400)
    expect { @connection.get "http://www.irythia.com/invalid_api_key" }.to raise_error(LoLBase::LoLBaseError)
  end

  it "returns an error if rate limits were reached" do
    stub_request(:get, "http://www.irythia.com/rate_limited").with(query: { api_key: "random-key" }).to_return(status: 429)
    expect { @connection.get "http://www.irythia.com/rate_limited" }.to raise_error(LoLBase::LoLBaseError)
  end

  it "returns an error if request can not be processed (data not found, etc.)" do
    stub_request(:get, "http://www.irythia.com/not_found").with(query: { api_key: "random-key" }).to_return(status: 404)
    expect { @connection.get "http://www.irythia.com/not_found" }.to raise_error(LoLBase::LoLBaseError)
  end

  it "returns an error if the API server is experiencing issues" do
    stub_request(:get, "http://www.irythia.com/server_error").with(query: { api_key: "random-key" }).to_return(status: 500)
    expect { @connection.get "http://www.irythia.com/server_error" }.to raise_error(LoLBase::LoLBaseError)
  end

  it "should allow for multiple connections using differing API keys" do
    stub_request(:get, "http://www.irythia.com/ok").with(query: { api_key: "random-key" }).to_return(status: 200, body: "random-key")
    stub_request(:get, "http://www.irythia.com/ok").with(query: { api_key: "random-key-2" }).to_return(status: 200, body: "random-key-2")

    @connection2 = LoLBase.new "random-key-2"

    expect(@connection.get "http://www.irythia.com/ok").to eq("random-key")
    expect(@connection2.get "http://www.irythia.com/ok").to eq("random-key-2")
  end

  it "should create a connection using the default key if none specified" do
    LoLBase.configure do |config|
      config.default_key = "blah"
    end

    stub_request(:get, "http://www.irythia.com/ok").with(query: { api_key: "blah" }).to_return(status: 200, body: "blah")
    connection = LoLBase.new
    expect(connection.get "http://www.irythia.com/ok").to eq("blah")
  end
end