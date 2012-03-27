require './gedcom-parse.rb'

$parser = GedParser.new()

File.open('royal.ged') do |file|
    while (line = file.gets)
        $parser.parseline(line)
    end
end

puts $parser.xml()
