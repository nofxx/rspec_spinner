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
      desc = clean_text example.respond_to?(:description) ? example.description : example
      @pbar.subject = desc
      super
    end

    def clean_text(text)
      text.respond_to?(:gsub) ? text.gsub(/\r|\n|\t/, "") : "No Description"
    end

  end
end
