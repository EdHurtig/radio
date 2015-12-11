require 'httpclient'

class TransmitCommand < Command
	def run(args)
		host = args[0]

		if !host.include?('://')
			host = "http://#{host}"
		end

		puts "Parsed Host #{host}"

		method = parse_action(args[1])

		puts "Parsed Meth #{method}"

		path = parse_path(args)

		puts "Parsed Path #{path}"

		body = parse_body(args.slice(2..-1) || [])
		headers = parse_headers(args.slice(2..-1) || [])

		url = host + path

		transmit(url, method, body, headers)
	end

	def keywords
		['transmit']
	end

	def parse_action(action)
		return 'GET' if action.nil?
		action_mapper = {
			'SHOW' => 'GET',
			'UPDATE' => 'PUT',
			'NEW' => 'POST',
			'CREATE' => 'POST'
		}

		method = action.upcase
		method = action_mapper[method] if action_mapper[method]

		method
	end

	def parse_path(args)

		return '/' if args.slice(2..-1).nil?

		path = '/' + args.slice(2..-1).select { |arg| !arg.include?(':') && !arg.include?('=') }.map { |arg| "#{arg}/" }.join('')

		return path
	end

	def parse_body(args)

		body = args.select { |arg| arg.include?('=') }.each_with_object(Hash.new) do |e, obj|
			kv = e.split(':')
			obj[kv[0]] = kv[1]
		end

		puts "Parsed Body #{body.inspect}"

		return body
	end


	def parse_headers(args)

		headers = args.select { |arg| arg.include?(':') }.each_with_object(Hash.new) do |e, obj|
			kv = e.split(':')
			obj[kv[0]] = kv[1]
		end

		puts "Parsed Headers #{headers.inspect}"

		return headers
	end

	def transmit(url, method, body, headers)
		http = HTTPClient.new
		http.set_cookie_store(ENV['RADIO_COOKIE_FILE']) if ENV['RADIO_COOKIE_FILE']

		if url.include?('?')
			query = CGI.parse(URI.parse(url).query).each_with_object([]) do |(k,vals), arr|
				vals.each { |v| arr << [k, v] }
			end
		end

		response = http.request(method.downcase.to_sym, url, query, body, headers) do |chunked_body|
			print chunked_body
		end

	end

end

Command.register TransmitCommand.new
