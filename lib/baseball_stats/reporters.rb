module BaseballStats
  module Reporters
    PLAYER_ID  = Calculators::PLAYER_ID
    FIRST_NAME = 'nameFirst'
    LAST_NAME  = 'nameLast'

    attr_accessor :year, :name_key

    def self.included(base)
      reporters << base
      base.extend(ClassMethods)
    end

    def self.reporters
      @reporters ||= []
    end

    module ClassMethods
      attr_reader :printer, :input_device, :name_key

      def report(*args)
        reporter = self.new(*args)
        printer.write(reporter.body)
      end

      def prompt(printer, input_device)
        @printer      = printer
        @input_device = input_device
        args          = [prompt_for_year]
        yield(args) if block_given?
        report(*args)
      end

      def prompt_for_year
        printer.write("Please enter the year you want to find stats for:")
        year = input_device.prompt
        year.to_i
      end

      def menu_name
        raise "Abstract class method .menu_name called for #{self.name}"
      end
    end

    def initialize(year)
      @year = year
      @name_key = CSV.parse(system_name_key, headers: true)
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

    private
    def system_name_key
      BaseballStats::DataSource.name_key
    end

    def player_name(id)
      return '(No winner)' if id == 0
      player = name_key.to_enum.detect { |n| n[PLAYER_ID] == id }
      [player[FIRST_NAME], player[LAST_NAME]].join(' ')
    end
  end
end

require 'baseball_stats/reporters/improved_batting_average'
require 'baseball_stats/reporters/slugging_percentage'
require 'baseball_stats/reporters/triple_crown_eligible'
