# How does IRB work?
def repl(binding)
  loop do
    print "irb knockoff> "    # input prompt
    input = gets.chomp        # grab the user input
    break if input == "break" # if needed, breaks out of the loop

    begin
      result = eval(input, binding)         # evaluates the input
      puts  "=> #{result.inspect}"          # print the result
    rescue Exception => e                   # catches an exception
      puts e.message                        # prints error message
      e.backtrace.each { |l| puts "  #{l}"} # prints backtrace
    end
  end
end

# How does Pry give you an IRB like prompt in a running program?
def debug(binding)
  repl(binding)
end

a = 123
debug(binding)
b = 456
