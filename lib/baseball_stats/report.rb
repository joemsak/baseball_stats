module BaseballStats
  class Report
    attr_reader :body, :printer

    class << self
      attr_accessor :raw_data
    end

    def initialize(raw_data)
      @printer = PlainTextPrinter.new
      @body = "* * * * Baseball Stats Reporter * * * *\n\n"
      self.class.raw_data = clean_data_source(raw_data)
    end

    def display_report
      reporters.each do |reporter|
        body << reporter.header
        begin
          body << reporter.result << "\n\n"
        rescue => e
          body << e.message
        end
      end
      printer.print(body)
    end

    private
    def clean_data_source(data)
      data.gsub("\r", "\n").gsub("\n\n", "\n").gsub(',,', ',0,')
    end

    def reporters
      triple_crown_reporter = Reporters::TripleCrownWinner

      [Reporters::ImprovedBattingAverage.new(2010),
       Reporters::SluggingPercentage.new(2007, 'OAK'),
       triple_crown_reporter.new(2011),
       triple_crown_reporter.new(2012)]
    end
  end
end
