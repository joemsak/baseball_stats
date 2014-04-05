module BaseballStats
  module UI
    class Menu
      attr_reader :reporters

      def initialize(reporters, printer, input_device)
        @reporters    = reporters
        @printer      = printer
        @input_device = input_device
      end

      def prompt
        reporters.each do |reporter|
          printer.write(reporter.menu_name)
        end
        printer.write("Please select from the options above.")
        option = input_device.prompt
      end
    end
  end
end
