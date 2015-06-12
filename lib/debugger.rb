require_relative "repl"

# How does Pry give you an IRB like prompt in a running program?
def debug(binding)
  should_start_repl = false

  trace_point = TracePoint.new do |tp|
    $tp = tp # try avoiding global variables in general!

    if should_start_repl
      repl(binding)
    else
      if tp.event == :return && tp.method_id == :debug
        should_start_repl = true
      end
    end
  end

  trace_point.enable
end

# How does Pry give you access to local variables?
def program(binding_1)
  a = 123
  b = 456
  binding_2 = binding
  puts "debugging with binding_1 (a & b not yet local variables)"
  debug binding_1
  puts "debugging with binding_2 (a equals 123, b equals 456)"
  debug binding_2
end

binding_1 = binding
program binding_1
