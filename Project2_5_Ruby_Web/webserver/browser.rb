require 'socket'
require 'json'


host = 'localhost'
port =  2000

#HTTP request to send to fetch a file


puts "Please select GET or POST"
input = gets.chomp

if input == "GET"

    request = "GET /index.html HTTP/1.0\r\n\r\n"

elsif input == "POST"

    puts "Enter your name:"
    name = gets.chomp
    puts "Enter your email:"
    email = gets.chomp

    hash_to_send = {:viking => {:name => name, :email => email} }

    hash_to_json = hash_to_send.to_json

    request = "POST /thanks.html HTTP/1.0\r\nContent-Length: #{hash_to_json.size}\r\n\r\n#{hash_to_json}"

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
socket.close
