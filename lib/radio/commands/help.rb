class HelpCommand < Command
	def run(args)
		puts open(File.join(File.dirname(File.dirname(__FILE__)), 'help.txt')).read
		exit 0
	end

	def keywords
		['help']
	end
end

Command.register HelpCommand.new
