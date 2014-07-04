require 'socket'
require 'json'

server = TCPServer.open(2000)

loop{

    Thread.start(server.accept) do |client|

        request = client.read_nonblock(256)

        header,body = request.split("\r\n\r\n", 2)

        fileName = header.split[1][1..-1]

        if File.exist?(fileName)

            file = File.open(fileName)

            if header.include?('POST')

                params = JSON.parse(body)

                user_data = "<li>name: #{params['viking']['name']}</li>\n<li>e-mail: #{params['viking']['email']}</li>"

                client.puts "POST /thanks.html HTTP/1.0 200 OK\n#{Time.now.ctime}\nContent-Length: #{fileName.size}\r\n\r\n" \
                    "#{file.read.gsub("<%= yield %>", user_data)}"

            elsif header.include?('GET')
                client.puts "GET /index.html HTTP/1.0 200 OK\n#{Time.now.ctime}\nContent-Length: #{fileName.size}\r\n\r\n#{file.read}"
            end

        else
            puts "HTTP/1.1 404/Object Not Found\r\nServer: ABC-server\r\n\r\n"
        end

    client.close

    end
}
