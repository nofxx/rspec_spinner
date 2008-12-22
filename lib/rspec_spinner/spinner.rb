module RspecSpinner
  class Spinner < RspecSpinnerBase


    def start(example_count)
      @current     = 0
      @total       = example_count
      @error_state = :all_passing
      @pbar        = Rtui::Progress.new("#{example_count} examples", example_count,
      {:out => output, :components => [:percentage, :spinner, :subject, :stat]})
      @pbar.subject = "Starting..."
    end

    def example_started(example)
      # this is strange , w/o this mouth work, you got some weird lines
      desc = example.description.to_s.chop.chomp.chop
      @pbar.subject = desc 
      super
    end
  end
end
