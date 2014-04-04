module BaseballStats
  class Report
    attr_accessor :message

    class << self
      attr_accessor :raw_data
    end

    def initialize(raw_data)
      @message  = ''
      self.class.raw_data = raw_data
    end

    def display_report
      construct_message
      $stdout.puts message
    end

    private
    def construct_message
      report_improved_batting_average
      message << "\n"
      report_slugging_percentage
      message << "\n"
      report_triple_crown_winners
      message << "\n"
    end

    def report_improved_batting_average
      message << improved_batting_average_reporter.header
      begin
        message << improved_batting_average_reporter.result
      rescue => e
        message << e.message
      end
    end

    def report_slugging_percentage
      message << "\n" << slugging_percentage_reporter.header
      begin
        message << slugging_percentage_reporter.result
      rescue => e
        message << e.message
      end
    end

    def report_triple_crown_winners
      [2011, 2012].each do |year|
        message << "\n" << triple_crown_reporter(year).header
        begin
          message << triple_crown_reporter(year).result << "\n"
        rescue => e
          message << e.message
        end
      end
    end

    def improved_batting_average_reporter
      Reporters::ImprovedBattingAverage.new(2010)
    end

    def slugging_percentage_reporter
      Reporters::SluggingPercentage.new(2007, 'OAK')
    end

    def triple_crown_reporter(year)
      Reporters::TripleCrownWinner.new(year)
    end
  end
end
