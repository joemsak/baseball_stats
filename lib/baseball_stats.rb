require 'csv'
require 'active_support/all'

require 'baseball_stats/version'
require 'baseball_stats/data_source'
require 'baseball_stats/calculators'
require 'baseball_stats/reporters'
require 'baseball_stats/ui'

module BaseballStats
  class << self
    def start
      set_data_source('./src/Batting-07-12.csv')
      set_player_key('./src/Master-small.csv')
      menu = UI::PlainTextMenu.new(Reporters.reporters,
                                   UI::Printers::PlainTextPrinter.new,
                                   UI::Input::PlainTextDevice.new)
      menu.prompt
    end

    private
    def set_data_source(filepath)
      BaseballStats::DataSource.set_raw_data(filepath)
    end

    def set_player_key(filepath)
      BaseballStats::DataSource.set_name_key(filepath)
    end
  end
end
