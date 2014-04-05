module BaseballStats
  module Reporters
    attr_accessor :year

    def self.included(base)
      reporters << base
      base.extend(ClassMethods)
    end

    def self.reporters
      @reporters ||= []
    end

    module ClassMethods
      def report(printer, *args)
        reporter = self.new(*args)
        printer.write(reporter.body)
      end

      def menu_name
        raise "Abstract class method .menu_name called for #{self.name}"
      end
    end

    def initialize(year)
      @year = year
    end

    def header
      raise "Abstract instance method #header called for #{self.class.name}"
    end

    def result
      raise "Abstract instance method #result called for #{self.class.name}"
    end

    def body
      body = header
      begin
        body << result << "\n\n"
      rescue => e
        body << e.message
      end
      body
    end
  end
end

require 'baseball_stats/reporters/improved_batting_average'
require 'baseball_stats/reporters/slugging_percentage'
require 'baseball_stats/reporters/triple_crown_eligible'
