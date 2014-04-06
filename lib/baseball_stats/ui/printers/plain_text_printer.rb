module BaseballStats
  module UI
    module Printers
      class PlainTextPrinter
        def write(body)
          $stdout.puts(body)
        end
      end
    end
  end
end
