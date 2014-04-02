module BaseballStats
  class Report
    attr_accessor :message

    def initialize(raw_data)
      @message  = ''
      @raw_data = raw_data
    end

    def display_report
      add_improved_batting_average_to_message
    end

    private
    def add_improved_batting_average_to_message
      begin
        @message << improved_batting_average_reporter.header
        @message << improved_batting_average_reporter.result
      rescue => e
        @message = e.message
      end
    end

    def improved_batting_average_reporter
      @improved_ba_reporter ||= Reporters::ImprovedBattingAverage.new(raw_data,
                                                                      2010)
    end

    def raw_data
      @raw_data ||= ''
    end
  end
end
