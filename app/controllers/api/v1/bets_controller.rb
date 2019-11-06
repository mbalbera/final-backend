require 'rest-client'
require 'base64'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class Api::V1::BetsController < ApplicationController

    def fetch_by_sport
        case params[:sport]
        when "ncaaf" || 1
            sport_num = 1
        when "nfl" || 2
            sport_num = 2
        when "mlb" || 3
            sport_num = 3
        when "nba" || 4
            sport_num = 4
        when "ncaam" || 5
            sport_num = 5
        when "nhl" || 6
            sport_num = 6
        else
            puts "invalid sport"
        end

        if sport_num && (sport_num > 0 && sport_num < 7)
            url = URI("https://therundown-therundown-v1.p.rapidapi.com/sports/#{sport_num}/events?include=all_periods&include=scores")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE

            request = Net::HTTP::Get.new(url)
            request["x-rapidapi-host"] = 'therundown-therundown-v1.p.rapidapi.com'
            request["x-rapidapi-key"] = Rails.application.credentials.dig(:API_KEY)
            puts Rails.application.credentials.dig(:API_KEY)

            events = http.request(request)
            parsed_events =JSON[events.read_body]
            parsed_events["events"].each do |event|
                fill_db(event,sport_num)
            end
        else
            return nil
        end
    end

    def fill_db(event, sport)
        most_recent = event["line_periods"].keys.map{|k| k.to_i}.max.to_s
        debugger
        Bet.create!( #MONEYLINE
            event_id: event["event_id"],
            category: sport,
            line: "",
            time: event["event_date"],
            text: "",
            status: event["score"]["event_status"],
            kind_of_bet: "moneyline",
            over_home_value: event["line_periods"][most_recent]["period_full_game"]["moneyline"]["moneyline_home"],
            under_away_value: event["line_periods"][most_recent]["period_full_game"]["moneyline"]["moneyline_away"],
            home_team_abr: event["teams_normalized"][0]["abbreviation"],
            away_team_abr: event["teams_normalized"][1]["abbreviation"],
            home_team_name: event["teams_normalized"][0]["name"] + " " + event["teams_normalized"][0]["mascot"],
            away_team_name: event["teams_normalized"][1]["name"] + " " + event["teams_normalized"][0]["mascot"],
            home_team_spread: 0,
            away_team_spread: 0
        )
        Bet.create!( #SPREAD
            event_id: event["event_id"],
            category: sport,
            line: "",
            time: event["event_date"],
            text: "",
            status: event["score"]["event_status"],
            kind_of_bet: "spread",
            over_home_value: event["line_periods"][most_recent]["period_full_game"]["spread"]["point_spread_home_money"],
            under_away_value: event["line_periods"][most_recent]["period_full_game"]["spread"]["point_spread_away_money"],
            home_team_abr: event["teams_normalized"][0]["abbreviation"],
            away_team_abr: event["teams_normalized"][1]["abbreviation"],
            home_team_name: event["teams_normalized"][0]["name"] + " " + event["teams_normalized"][0]["mascot"],
            away_team_name: event["teams_normalized"][1]["name"] + " " + event["teams_normalized"][0]["mascot"],
            home_team_spread: event["line_periods"][most_recent]["period_full_game"]["spread"]["point_spread_home"],
            away_team_spread: event["line_periods"][most_recent]["period_full_game"]["spread"]["point_spread_away"]
        )
        Bet.create!( #TOTAL
            event_id: event["event_id"],
            category: sport,
            line: "",
            time: event["event_date"],
            text: "",
            status: event["score"]["event_status"],
            kind_of_bet: "total",
            over_home_value: event["line_periods"][most_recent]["period_full_game"]["total"]["total_over_money"],
            under_away_value: event["line_periods"][most_recent]["period_full_game"]["total"]["total_under_money"],
            home_team_abr: event["teams_normalized"][0]["abbreviation"],
            away_team_abr: event["teams_normalized"][1]["abbreviation"],
            home_team_name: event["teams_normalized"][0]["name"] + " " + event["teams_normalized"][0]["mascot"],
            away_team_name: event["teams_normalized"][1]["name"] + " " + event["teams_normalized"][0]["mascot"],
            home_team_spread: event["line_periods"][most_recent]["period_full_game"]["total"]["total_over"],
            away_team_spread: event["line_periods"][most_recent]["period_full_game"]["total"]["total_over"]
        )

    end



=begin
    #change sport in fetch after sports/ 1-NCAAF,2-NFL, 3-MLB, 4-NBA, 5-NCAAM, 6-NHL
    arr[1]["events"].each do |event| # to get from fetch to individual event
    arr["event_date"] # event start date
    arr["teams_normalized"][0].abbreviation # team 1 ABR 
    arr["teams_normalized"][1].abbreviation # team 2 ABR 
    arr[1]["events"][0]["score"]["event_status"] # event status
=end

end




