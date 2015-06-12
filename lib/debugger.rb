require_relative "repl"

# How does Pry Rails limit the number of debug sessions to one?
def debug(binding)
  should_start_repl = false
  thread = Thread.current

  trace_point = TracePoint.new do |tp|
    $tp = tp # try avoiding global variables in general!

    if should_start_repl && thread == Thread.current
      repl(binding)
    else
      if tp.event == :return && tp.method_id == :debug
        should_start_repl = true
      end
    end
  end

  trace_point.enable
end
