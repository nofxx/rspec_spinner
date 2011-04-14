require "spec/runner/formatter/base_text_formatter"
require "rubygems"
require "rtui"

module RspecSpinner
  class RspecSpinnerBase < Spec::Runner::Formatter::BaseTextFormatter
    # Threshold for slow specs, in seconds.
    # Anything that takes longer than this will be printed out
    #THRESHOLD = 0.25
    THRESHOLD = 3.0

    attr_reader :total, :current

    def initialize(options, where)
      super
      @example_times = []
    end

    def start(example_count)
      @current     = 0
      @total       = example_count
      @error_state = :all_passing
      @pbar        = RTUI::Progress.new("#{example_count} examples", example_count,
      {:out => output, :components => [:percentage, :spinner, :stat]})
    end

    def example_started(example)
      super
      @start_time = Time.now
    end

    def example_passed(example)
      ex = [example_group.description, example.description, example.location, Time.now - @start_time]
      print_warning_if_slow(*ex)
      @example_times << ex
      increment
    end

    # third param is optional, because earlier versions of rspec sent only two args
    def example_pending(example, message, deprecated_pending_location=nil)
      immediately_dump_pending(example.description, message, example.location)
      mark_error_state_pending
      increment
    end

    def example_failed(example, counter, failure)
      immediately_dump_failure(counter, failure)
      mark_error_state_failed
      increment
    end

    def start_dump
      output.flush
      super
      @output.puts "\n\nTop 15 slowest examples:\n"

      @example_times = @example_times.sort_by do |description, example, location, time|
        time
      end.reverse

      @example_times[0..14].each do |description, example, location, time|
        _,line = location.split(":")
        @output.print red(sprintf("%.7f", time))
        @output.puts " #{description}:#{line} #{example}"
      end
      @output.flush
    end

    def dump_failure(*args)
      # no-op; we summarized failures as we were running
    end

    def method_missing(sym, *args)
      # ignore
    end

    # stolen and slightly modified from BaseTextFormatter#dump_failure
    def immediately_dump_failure(counter, failure)
      erase_current_line
      output.puts
      output.print "#{counter.to_s}) "
      # Rspec 1.2.2
      output.puts colorize_failure("#{failure.header}\n#{failure.exception.message}", failure)
      output.puts format_backtrace(failure.exception.backtrace)
      output.puts
    end

    # stolen and modified from BaseTextFormatter#dump_pending
    def immediately_dump_pending(desc, msg, location)
      erase_current_line
      output.puts yellow("PENDING SPEC:") + " #{desc} (#{msg})"
      output.puts format_backtrace("  Called from #{location}")
      output.puts
    end

    def increment
      with_color do
        @current += 1
        # HACK: need to make sure the progress is printed, even when the bar hasn't changed
        if /^1\.8/ === RUBY_VERSION then
          @pbar.instance_variable_set("@previous", 0)
          @pbar.instance_variable_set("@title", "#{current}/#{total}")
        else
          @pbar.instance_variable_set("@previous".to_sym, 0)
          @pbar.instance_variable_set("@title".to_sym, "#{current}/#{total}")
        end
        @pbar.inc
      end
      output.flush
    end

    ERROR_STATE_COLORS = {
      :all_passing  => "\e[32m", # green
      :some_pending => "\e[33m", # yellow
      :some_failed  => "\e[31m", # red
      :pending_fix  => "\e[34m", # blue
    }

    def with_color
      use_color = colour? && output_to_tty?
      output.print ERROR_STATE_COLORS[@error_state] if use_color
      yield
      output.print "\e[0m" if use_color
    end

    def mark_error_state_failed
      @error_state = :some_failed
    end

    def mark_error_state_pending
      @error_state = :some_pending unless @error_state == :some_failed
    end

    def erase_current_line
      output.print "\e[K"
    end

    def print_warning_if_slow(group, example, location, elapsed)
      if elapsed > THRESHOLD
        #mark_error_state(:pending)
        erase_current_line
        output.print yellow("SLOW SPEC: #{sprintf("%.4f", elapsed)} ")
        output.print "  FROM: #{location} / #{group} #{example}"
        output.puts
      end
    end
  end
end
