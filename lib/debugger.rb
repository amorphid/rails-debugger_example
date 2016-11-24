module Debugger
  def debug(binding)
    should_start_repl = false
    repl_completed    = false
    thread = Thread.current

    trace_point = TracePoint.new do |tp|
      if should_start_repl && thread == Thread.current && repl_completed == false
        repl(binding)
        repl_completed = true
      else
        if tp.event == :return && tp.method_id == :debug
          should_start_repl = true
        end
      end
    end

    trace_point.enable
  end

  def repl(binding)
    loop do
      print "irb knockoff> "    # input prompt
      input = STDIN.gets.chomp  # grab the user input
      break if input == "break"
      system("kill -9 #{Process.pid}") if input == "kill"

      begin
        result = eval(input, binding)         # evaluates the input
        puts  "=> #{result.inspect}"          # print the result
      rescue Exception => e                   # catches an exception
        puts e.message                        # prints error message
        e.backtrace.each { |l| puts "  #{l}"} # prints backtrace
      end
    end
  end
end
