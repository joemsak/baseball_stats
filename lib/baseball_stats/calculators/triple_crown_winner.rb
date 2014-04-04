module BaseballStats
  module Calculators
    class TripleCrownWinner
      include Calculators

      def calculate
        al_winner = find_winner(AMERICAN_LEAGUE)
        nl_winner = find_winner(NATIONAL_LEAGUE)
        { 'American League' => al_winner[PLAYER_ID],
          'National League' => nl_winner[PLAYER_ID] }
      end

      private
      def find_winner(league)
        players = select_eligible_players(league)
        max_RBI = get_max_stat(players, RBI)
        max_HR  = get_max_stat(players, HOMERUNS)

        rbi_matches = players.select { |p| p[RBI] == max_RBI }
        hr_matches  = rbi_matches.select { |p| p[HOMERUNS] == max_HR }
        hr_matches.max_by { |p| batting_average(p) } || { PLAYER_ID => 0 }
      end

      def batting_average(stats)
        ImprovedBattingAverage.formula(stats)
      end

      def get_max_stat(collection, stat)
        collection.max_by { |p| p[stat] }[stat] rescue 0
      end

      def select_eligible_players(league)
        eligible_players.select { |p| p[LEAGUE] == league }
      end

      def eligible_players
        select_from_csv do |player|
          player[AT_BATS] > 399 && player[YEAR_ID] == year
        end
      end
    end
  end
end
