# LoLBase

A basic Ruby wrapper for the League of Legends API.

* GitHub: [https://github.com/Illianthe/lolbase](https://github.com/Illianthe/lolbase)
* RubyGems: [https://rubygems.org/gems/lolbase](https://rubygems.org/gems/lolbase)

## Installation

Add this line to your application's Gemfile:

	gem 'lolbase'

And in the console, execute:

	$ bundle

## Usage

### 1. Configuration

LoLBase can be globally configured through the *LoLBase::configure* method. The values shown are the defaults set by the gem.

	LoLBase.configure do |config|
	  config.default_region = "na"    # Default region for summoner lookup
	  config.default_key = nil        # Default API key

	  # Latest versions of the API provided by Riot. These values can 
	  # be changed for backward compatibility.
	  config.version_champion = "1.1"
      config.version_game = "1.1"
      config.version_league = "2.1"
      config.version_stats = "1.1"
      config.version_summoner = "1.1"
      config.version_team = "2.1"
	end

### 2. Connection

	connection = LoLBase.new "your-api-key-here"

All connections begin by calling *LoLBase::new* which takes an API key as an argument (this can be left blank if it was provided in the config). Multiple connections can be used if you have more than one key available to you.

### 3. Data Retrieval

#### 3.1 Summoner

	# Fetch a summoner by their name...
	summoner = connection.summoner("A Summoner Name", "na")

	# ...or by their ID
	summoner = connection.summoner(12345, "euw")

	# Retrieve data associated to the summoner
	summoner.id
	summoner.name
	summoner.region
	summoner.level
	summoner.last_modified

#### 3.2 Profile Icon

	summoner.profile_icon.id

## Resources

* Official API Reference: [https://developer.riotgames.com/api/methods](https://developer.riotgames.com/api/methods) 