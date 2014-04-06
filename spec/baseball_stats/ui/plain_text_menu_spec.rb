require 'baseball_stats/ui/plain_text_menu'

module BaseballStats
  module UI
    describe PlainTextMenu do
      let(:reporters)    { [double(:reporter, menu_name: 'Reporter Name 1'),
                            double(:reporter, menu_name: 'Reporter Name 2')] }
      let(:printer)      { double(:printer).as_null_object }
      let(:input_device) { double(:input_device).as_null_object }

      subject { PlainTextMenu.new(reporters, printer, input_device) }

      def assert_printed(txt)
        printer.should_receive(:write).with(txt)
      end

      describe "initialize" do
        it "writes the printer's header" do
          PlainTextMenu.any_instance.stub(:header) { 'Menu header' }
          assert_printed('Menu header')
          subject
        end
      end

      describe "#prompt" do
        before { subject.stub(:run_option) }

        it "writes the reporter names to the printer" do
          assert_printed('1. Reporter Name 1')
          assert_printed('2. Reporter Name 2')
          subject.prompt
        end

        it "writes the quit option to the printer" do
          assert_printed('q. Quit')
          subject.prompt
        end

        it "asks the user to make a choice" do
          assert_printed("\nPlease select from the options above:")
          input_device.should_receive(:prompt)
          subject.prompt
        end

        it "passes the user's option to the #run_option function" do
          input_device.stub(:prompt) { '1' }
          subject.should_receive(:run_option).with('1')
          subject.prompt
        end
      end

      describe "#run_option" do
        before { subject.stub(:prompt_to_start_over_or_quit) }

        context "when option is unrecognized" do
          it "tells the user it's confused and asks to prompt again or quit" do
            assert_printed("\nSorry! We didn't recognize that option!")
            subject.should_receive(:prompt_to_start_over_or_quit)
            subject.run_option('h')
          end
        end

        context "when the option is Q/q" do
          it "quits" do
            ['Q', 'q'].each do |q|
              subject.should_receive(:exit)
              subject.run_option(q)
            end
          end
        end

        context "when the option is a number from the menu" do
          it "prompts that reporter with devices, asks to restart or quit" do
            reporters[0].should_receive(:prompt).with(printer, input_device)
            subject.should_receive(:prompt_to_start_over_or_quit)
            subject.run_option('1')
          end
        end
      end
    end
  end
end
