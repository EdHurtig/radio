class Command
	def run(args)
		raise "Not Implemented"
	end

	def self.register(new_command)
		@@_commands << new_command
	end

	def self.all
		@@_commands
	end

	def self.get(keyword)
		Command.all.select { |cmd| cmd.keywords.include?(keyword) }
	end

	def keywords
		[]
	end

	def self.run(keyword, args)
		Command.get(keyword).map do |cmd|
			puts "Running command #{cmd} with args #{args}"
			cmd.run(args.deep_dup)
		end
	end

	def run(args)
		raise 'Not Implemented'
	end

	private
		@@_commands = []
end
