require 'baseball_stats/ui/input/plain_text_device'

module BaseballStats
  module UI
    module Input
      describe PlainTextDevice do
        subject { PlainTextDevice.new }

        describe "#prompt" do
          it "asks for input from stdin" do
            $stdin.should_receive(:gets)
            subject.prompt
          end
        end
      end
    end
  end
end
