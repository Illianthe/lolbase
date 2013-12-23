# LoLBase [![Build Status](https://travis-ci.org/Illianthe/lolbase.png?branch=master)](https://travis-ci.org/Illianthe/lolbase) [![Code Climate](https://codeclimate.com/github/Illianthe/lolbase.png)](https://codeclimate.com/github/Illianthe/lolbase) [![Gem Version](https://badge.fury.io/rb/lolbase.png)](http://badge.fury.io/rb/lolbase)

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

	  # Determines which API version to use
	  config.version_champion = "1.1"
      config.version_game = "1.2"
      config.version_league = "2.2"
      config.version_stats = "1.2"
      config.version_summoner = "1.2"
      config.version_team = "2.2"

      # Current season - used as a default value for ranked stats
      config.current_season = "3"
	end

### 2. Connection

	connection = LoLBase.new "your-api-key-here"

All connections begin by calling *LoLBase::new* which takes an API key as an argument (this can be left blank if it was provided in the config). Multiple connections can be used if you have more than one key available to you.

### 3. Data Retrieval

#### 3.1 Champion

	# Fetch a list of all the champions in the game
	champions = connection.champions.all

	# Find a specific subset of champions
	f2p_champs = connection.champions.find(free_to_play: true)
	champ = connection.champions.find(id: 99)
	champ = connection.champions.find(name: "Lux")

	# Given a single champion, retrieve details about it
	champ.id
	champ.name
	champ.status    # Check whether it is enabled in a given queue
	champ.stats     # Ratings for attributes/difficulty

#### 3.2 Summoner

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

#### 3.3 Profile Icon

	summoner.profile_icon.id

#### 3.4 Statistics

	# A specified ranked season is passed - defaults to LoLBase.config.current_season
	summary = summoner.stats.summary(3)    
	ranked = summoner.stats.ranked(3)

	# Retrieve the stats summary for a particular queue type
	aram = summary.find(name: "AramUnranked5x5")
	aram.stats["wins"]
	aram.last_modified

	# Retrieve all recorded stats summaries
	summary.all

	# Retrieve the ranked stats for a particular champion
	lux = ranked.find(champion_id: 99)
	games_played = lux.stats["totalSessionsPlayed"]

	# Retrieve the ranked stats for all champions
	ranked.all

	# Aggregated stats for ranked play
	ranked.overall
	ranked.last_modified

## Resources

* Official API Reference: [https://developer.riotgames.com/api/methods](https://developer.riotgames.com/api/methods) 