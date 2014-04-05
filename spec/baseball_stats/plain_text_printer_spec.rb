require 'baseball_stats/plain_text_printer'
module BaseballStats
  describe PlainTextPrinter do
    subject { PlainTextPrinter.new }

    describe "#print" do
      it "sends anything to stdout" do
        [nil, '', 0, 3.14, 'foo'].each do |content|
          $stdout.should_receive(:puts).with(content)
          subject.print(content)
        end
      end
    end
  end
end
