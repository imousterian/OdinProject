require 'socket'


host = 'localhost'
port =  2000
path = "/index.htm"

#HTTP request to send to fetch a file
# request = "GET #{path} HTTP/1.0\r\n\r\n"
#request = "GET /index.html HTTP/1.0\r\n\r\n"

puts "Please select GET or POST"
if "GET"
    request = "GET /index.html HTTP/1.0\r\n\r\n"
else
    request = "POST /thanks.html HTTP/1.0\r\n\r\n"
end


#connect to server
socket = TCPSocket.open(host,port)
#send request
socket.print(request)
#read complete response
response = socket.read
#split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)
print body
