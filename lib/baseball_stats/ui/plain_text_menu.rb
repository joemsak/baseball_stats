module BaseballStats
  module UI
    class PlainTextMenu
      attr_reader :reporters, :printer, :input_device

      def initialize(reporters, printer, input_device)
        @reporters    = reporters
        @printer      = printer
        @input_device = input_device
      end

      def prompt
        printer.write(printer.header)

        reporters.each_with_index do |reporter, i|
          printer.write("#{i + 1}. " << reporter.menu_name)
        end

        printer.write("\nPlease select from the options above.")

        option = input_device.prompt
        if reporter = reporters[option.to_i - 1]
          reporter.prompt(printer, input_device)
        else
          printer.write("\nCouldn't recognize that option!")
          prompt
        end
      end
    end
  end
end
