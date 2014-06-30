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

    gsubbed_phone = phone.gsub(/\D/, '')

    if gsubbed_phone.length == 10 || (gsubbed_phone.length == 11 && gsubbed_phone[0] == '1')
        gsubbed_phone.rjust(11,'1')[1...11]
    else
        '0000000000'
    end

end

def time_targeting(time)

    d = DateTime.strptime(time, '%m/%d/%y %H:%M')

    if @records.has_key?(d.hour)
        @records[d.hour] += 1
    else
        @records[d.hour] = 1
    end

    @records.values.max

end


template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
contents = CSV.open "full_event_attendees.csv", headers: true, header_converters: :symbol
@records = Hash.new
contents.each do |row|

    id = row[0]

    name = row[:first_name]

    zipcode = clean_zipcode(row[:zipcode])

    phone = clean_phone_numbers(row[:homephone])

    busiest_hour = time_targeting(row[:regdate])


    # legislators = legislators_by_zipcode(zipcode)

    # form_letter = erb_template.result(binding)

    # save_thank_you_letters(id, form_letter)

end















