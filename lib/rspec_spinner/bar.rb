module RspecSpinner
  class Bar < RspecSpinnerBase


    def start(example_count)
      @current     = 0
      @total       = example_count
      @error_state = :all_passing
      @pbar        = RTUI::Progress.new("#{example_count} examples", example_count,
      {:out => output})
    end
  end
end



