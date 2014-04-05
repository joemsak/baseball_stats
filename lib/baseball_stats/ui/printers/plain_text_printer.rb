module BaseballStats
  module UI
    module Printers
      class PlainTextPrinter
        def write(body)
          $stdout.puts(body)
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
      end
    end
  end
end
