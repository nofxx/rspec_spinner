require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "Spinner" do

  before(:each) do
    class PassingGroup;  end
    @passing_group = PassingGroup.describe("passing_group") do
      specify "passing" do
        true.should be_true
      end
    end
    @io = StringIO.new
    @options = mock('options')
    @options.stub!(:dry_run).and_return(false)
    @options.stub!(:colour).and_return(false)
    @formatter = RspecSpinner::Spinner.new(@options, @io)
  end

  it "should print the description on the avaiable space" do
    @mock_pbar = mock("ProgressBar")
    Rtui::Progress.should_receive(:new).and_return(@mock_pbar)
    @mock_pbar.should_receive("subject=").with("Starting...")
    @formatter.start(1)
    @mock_pbar.should_receive("subject=").with("passing")
    @formatter.example_started(@passing_group.examples.first)
  end

end
