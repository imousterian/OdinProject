require 'socket'


server = TCPServer.open(2000)

loop{

    client = server.accept

    request = client.gets

    Thread.start(client) do |client|
        # request = client.read_nonblock(256) #cllient.gets
        header,body = request.split("\r\n\r\n", 2)
        # fileName = request.gsub(/GET /, '').gsub(/ HTTP.*/, '')
        fileName = request.match(/(\w+\/)*\w+\.\w+/)[0]
        http_method = header
        # puts request
        puts http_method

        if File.exist?(fileName)
            print "HTTP/1.1 200/OK\r\nServer: ABC-server\r\nContent-type:text/html\r\n\r\n"

            file = File.open(fileName)
            # puts file
            while (not file.eof?)
                buffer = file.read(256)
                # puts buffer
            end

        else
            puts "HTTP/1.1 404/Object Not Found\r\nServer: ABC-server\r\n\r\n"
        end

    end

    # client.puts(Time.now.ctime)
    # client.puts "Closing the connection."
    client.close
}
