require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "Base" do

  before(:each) do
    @io = StringIO.new
    @options = mock('options')
    @options.stub!(:dry_run).and_return(false)
    @options.stub!(:colour).and_return(false)
    @formatter = RspecSpinner::Bar.new(@options, @io)
  end

  it "should produce line break on start dump" do
    @formatter.start_dump
    @io.string.should eql("")
  end

  it "should produce standard summary without pending when pending has a 0 count" do
      @options.should_receive(:autospec).and_return(true)
    @formatter.dump_summary(3, 2, 1, 0)
    @io.string.should eql("\nFinished in 3 seconds\n\n2 examples, 1 failure\n")
  end

  describe "Examples" do

    before(:all) do
      class PassingGroup;  end
      class PendingGroup;  end
      @passing_group = PassingGroup.describe("passing_group") do
        specify "passing" do
          true.should be_true
        end
      end
      @pending_group = PendingGroup.describe("pending_group") do
        specify "pending" do
        end
      end
    end

    it "should produce standard summary" do
      @options.should_receive(:autospec).exactly(2).times.and_return(true)
      example = @pending_group.examples.first
      @formatter.start(1)
      @formatter.example_pending(example, "message", "file/here:35")
      @io.rewind
      @formatter.dump_summary(3, 2, 1, 1)
      @io.string.should eql("\nFinished in 3 seconds\n\n2 examples, 1 failure, 1 pending\n                       \r1 examples:   0% |                                             | ETA:  --:--:--\r\e[KPENDING SPEC: pending (message)\n  Called from ./spec/rspec_spinner/base_spec.rb:35:\n\n1/1: 100% |====================================================| ETA:  00:00:00\r")
    end

    it "should update status and go green for passing spec" do
      pending
      @example = mock("Example", :description => "Foo") #@passing_group.examples.first
      @io.should_receive(:tty?).and_return(true)
      @options.should_receive(:colour).and_return(true)
      @formatter.start(1)
      #@formatter.example_started(example)
      @formatter.example_passed(@example)
      @io.string.should == "\e[32m.\e[0m"
    end

    describe "Pending" do

      it "should output pending spec immediately (in yellow)" do
        @options.should_receive(:colour).and_return(true)
        @options.should_receive(:autospec).and_return(true)
        @formatter.start(1)
        @mock_message = mock("PENDING", :description => "Oi", :backtrace => "Bad", :location => "Foo l 20")
        @formatter.example_pending(@mock_message, "Teste")
        @io.string.should eql("\r                                                                               \r1 examples:   0% |                                             | ETA:  --:--:--\r\e[K\e[33mPENDING SPEC:\e[0m Oi (Teste)\n  Called from Foo l 20\n\n1/1: 100% |====================================================| ETA:  00:00:00\r")
      end

    end

    describe "Failure" do

      it "should output failure spec immediately (in red)" do
        # @io.should_receive(:tty?).and_return(true)
        @options.should_receive(:colour).and_return(true)
        @options.should_receive(:autospec).and_return(true)
        @formatter.start(1)
        @mock_message = mock("FAIL", :message => "Really bad", :backtrace => "Bad")
        @formatter.example_failed("spec", 98, mock("SpecFail", :exception => @mock_message, :header => "Evil failure", :pending_fixed? => false))
        @io.string.should eql("\r                                                                               \r1 examples:   0% |                                             | ETA:  --:--:--\r\e[K\n98) \e[31mEvil failure\nReally bad\e[0m\nBad\n\n1/1: 100% |====================================================| ETA:  00:00:00\r")
      end

      it "should push blue for fixed pending spec" do
        @options.should_receive(:colour).and_return(true)
        @options.should_receive(:autospec).and_return(true)
        @formatter.start(1)
        @mock_message = mock("FAIL", :message => "Really bad", :backtrace => "Bad")
        @formatter.example_failed("spec", 98, mock("SpecFail", :exception => @mock_message, :header => "Evil failure", :pending_fixed? => true))
        @io.string.should eql("\r                                                                               \r1 examples:   0% |                                             | ETA:  --:--:--\r\e[K\n98) \e[34mEvil failure\nReally bad\e[0m\nBad\n\n1/1: 100% |====================================================| ETA:  00:00:00\r")
      end
    end

    it "should push slow specs" do
      # @io.should_receive(:tty?).and_return(true)
      @options.should_receive(:colour).and_return(true)
      Time.should_receive(:now).and_return(Date.parse "10/10/2000 10:10:10")
      Time.should_receive(:now).and_return(Date.parse "10/10/2009 10:10:10")
      @mock_slow = mock("SLOW", :description => "Pending Fixed", :location => "Foo")
      @formatter.start(1)
      @formatter.example_started(@mock_slow)
      @formatter.example_passed(@mock_slow)
      @io.string.should eql("\r                                                                               \r1 examples:   0% |                                             | ETA:  --:--:--\r\e[32m1/1: 100% |====================================================| ETA:  00:00:00\r\e[0m")
    end

    it "should push some stuff on start" do
      @formatter.start(4)
      @io.string.should eql("\r                                                                               \r4 examples:   0% |                                             | ETA:  --:--:--\r")
    end

    it "should not dump anything on the end" do
      @formatter.dump_failure.should be_nil
    end

    it "should ignore method missing" do
      @formatter.method_missing(:foo).should be_nil
    end

    it "should erase current line" do
       @formatter.erase_current_line
       @io.string.should eql("\e[K")
    end

  end
end
