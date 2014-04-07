require 'baseball_stats/ui/printers/plain_text_printer'

module BaseballStats
  module UI
    module Printers
      describe PlainTextPrinter do
        subject { PlainTextPrinter.new }

        describe "#write" do
          it "sends anything to stdout" do
            [nil, '', 0, 3.14, 'foo'].each do |content|
              $stdout.should_receive(:puts).with(content)
              subject.write(content)
            end
          end
        end
      end
    end
  end
end
