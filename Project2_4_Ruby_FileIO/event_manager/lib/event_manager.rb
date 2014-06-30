require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

puts "EventManager Initialized!"

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
    Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
    Dir.mkdir("output") unless Dir.exists? "output"

    filename = "output/thanks_#{id}.html"

    File.open(filename, 'w') do |file|
        file.puts form_letter
    end
end

def clean_phone_numbers(phone)

    # =begin
    #     If the phone number is less than 10 digits assume that it is a bad number
    #     If the phone number is 10 digits assume that it is good
    #     If the phone number is 11 digits and the first number is 1, trim the 1 and use the first 10 digits
    #     If the phone number is 11 digits and the first number is not 1, then it is a bad number
    #     If the phone number is more than 11 digits assume that it is a bad number
    # =end

    gsubbed_phone = phone.gsub(/\D/, '')

    if gsubbed_phone.length == 10 || (gsubbed_phone.length == 11 && gsubbed_phone[0] == '1')
        gsubbed_phone.rjust(11,'1')[1...11]
    else
        '0000000000'
    end

end

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
contents = CSV.open "full_event_attendees.csv", headers: true, header_converters: :symbol

contents.each do |row|

    id = row[0]

    name = row[:first_name]

    zipcode = clean_zipcode(row[:zipcode])

    phone = clean_phone_numbers(row[:homephone])

    # legislators = legislators_by_zipcode(zipcode)

    # form_letter = erb_template.result(binding)

    # save_thank_you_letters(id, form_letter)

end














