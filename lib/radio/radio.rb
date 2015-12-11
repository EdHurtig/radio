require 'optparse'
require 'optparse/time'
require 'ostruct'

def load_commands
	require_relative 'command.rb'
	require_relative 'lib.rb'
	puts "Loading Commands"

	Dir.glob(File.join('./commands', '*.rb')).each do |cmd|
		puts "Loading Command #{cmd}"
		require_relative cmd
	end
end

load_commands()



class OptparseExample
  #
  # Return a structure describing the options.
  #
  def self.parse(args)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.verbose = false

    opt_parser = OptionParser.new do |opts|

      # Boolean switch.
      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options.verbose = v
      end

      # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      opts.on_tail("-h", "--help", "Show this message") do
				Command.get('help').first.run([])
				exit
      end

      # Another typical switch to print the version.
      opts.on_tail("--version", "Show version") do
        puts ::Version.join('.')
        exit
      end
    end

    opt_parser.parse!(args)
    options
  end  # parse()

end  # class OptparseExample

options = OptparseExample.parse(ARGV)
puts options

command = ARGV.shift

results = Command.run(command, ARGV)

exit 0 if results.any?

ARGV.unshift(command)

if ARGV.length > 0
	Command.get('transmit').first.run(ARGV)
else
	Command.get('help').first.run([])
end
