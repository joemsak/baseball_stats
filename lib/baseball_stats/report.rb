module BaseballStats
  class Report
    def initialize(raw_data)
      @body = printer.header
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

    def body
      @body ||= ''
    end

    class << self
      def raw_data; @raw_data ||= ''; end
      def raw_data=(str); @raw_data = str; end
    end

    def printer
      PlainTextPrinter.new
    end

    private
    def clean_data_source(data)
      data.gsub("\r", "\n").gsub("\n\n", "\n").gsub(',,', ',0,')
    end

    def reporters
      triple_crown_reporter = Reporters::TripleCrownEligible

      [Reporters::ImprovedBattingAverage.new(2010),
       Reporters::SluggingPercentage.new(2007, 'OAK'),
       triple_crown_reporter.new(2011),
       triple_crown_reporter.new(2012)]
    end
  end
end
