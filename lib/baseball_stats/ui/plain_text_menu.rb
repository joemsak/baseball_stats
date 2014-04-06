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
        option   = option.to_i
        reporter = reporters[option - 1]

        if reporter && !option.zero?
          reporter.prompt(printer, input_device)
        else
          output_unrecognized_option_message
        end

        prompt_to_start_over_or_quit
      end

      private
      def output_header
        printer.write(header)
      end

      def header
        <<-EOD

          * * * * * * * * * * * * * * * * * * * *
          *           Welcome! To the           *
          *       Baseball Stats Reporter       *
          *             Play ball!              *
          *    (well, read about ppl who do)    *
          * * * * * * * * * * * * * * * * * * * *

        EOD
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
        option = input_device.prompt
        prompt if option == "\n"
        exit   if quitting?(option)
        prompt_to_start_over_or_quit
      end

      def quitting?(input)
        input && input.downcase.strip == 'q'
      end
    end
  end
end
