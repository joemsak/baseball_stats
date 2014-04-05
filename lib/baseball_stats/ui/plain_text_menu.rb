module BaseballStats
  module UI
    class PlainTextMenu
      attr_reader :reporters, :printer, :input_device

      def initialize(reporters, printer, input_device)
        @reporters    = reporters
        @printer      = printer
        @input_device = input_device
        output_header
      end

      def prompt
        output_reporters_options
        output_quit_option
        output_selection_line

        option = input_device.prompt
        run_option(option)
      end

      def run_option(option)
        exit if quitting?(option)

        if reporter = reporters[option.to_i - 1]
          reporter.prompt(printer, input_device)
          prompt_to_start_over_or_quit
        else
          output_unrecognized_option_message
          prompt_to_start_over_or_quit
        end
      end

      private
      def output_header
        printer.write(printer.header)
      end

      def output_reporters_options
        reporters.each_with_index do |reporter, i|
          printer.write("#{i + 1}. " << reporter.menu_name)
        end
      end

      def output_quit_option
        printer.write("q. Quit")
      end

      def output_selection_line
        printer.write("\nPlease select from the options above:")
      end

      def output_unrecognized_option_message
        printer.write("\nSorry! We didn't recognize that option!")
      end

      def prompt_to_start_over_or_quit
        printer.write("\nPress [Enter] to start over, or 'q' to Quit.")
        selection = input_device.prompt
        if quitting?(selection)
          exit
        elsif selection == "\n"
          prompt
        else
          output_unrecognized_option_message
          prompt_to_start_over_or_quit
        end
      end

      def quitting?(input)
        input && input.downcase.strip == 'q'
      end
    end
  end
end
