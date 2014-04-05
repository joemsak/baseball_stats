module BaseballStats
  module UI
    module Input
      class PlainTextDevice
        def prompt
          $stdin.gets
        end
      end
    end
  end
end
