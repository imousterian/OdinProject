require 'jumpstart_auth'

class MicroBlogger
    attr_reader :client

    def initialize
        puts "Initializing"
        @client = JumpstartAuth.twitter
    end

    def tweet(message)
        if message.length <= 140
            @client.update(message)
        else
            puts "Too long!"
        end
    end

    def dm(target, message)
        puts "Trying to send #{target} this direct message:"
        puts message

        if followers_list.include?(target)
            str = "d #{target} #{message}"
            tweet(str)
        else
            puts "You can only DM your followers!"
        end
    end

    def followers_list
        screen_names = @client.followers.collect{|follower| follower.screen_name}
    end

    def spam_my_followers(message)
        followers = followers_list
        followers.each { |f| dm(f, message) }
    end

    def run
        puts "Welcome to the JSL Twitter Client!"
        command = ""

        while command != "q"
            puts ""
            printf "enter command: "
            input = gets.chomp
            parts = input.split
            command = parts[0]

            case command
                when 'q' then puts "Goodbye!"
                when 't' then tweet(parts[1..-1].join(" "))
                when 'dm' then dm(parts[1], parts[2..-1].join(" "))
                when 'spam' then spam_my_followers(parts[1..-1].join(" "))
                else
                    puts "Sorry, I don't know how to #{command}"
                end

        end
    end
end

blogger = MicroBlogger.new
blogger.run
