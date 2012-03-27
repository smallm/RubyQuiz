require './XMElement.rb'

class GedParser
    attr_reader :base_element, :current_element, :current_level

    def initialize()
        @base_element = XMElement.new('gedcom', nil, nil)
        @current_element = @base_element
        @current_level = -1
    end

    def parseline(line)
        return if !line or line =~ /^[\s]$/ or line.empty?
        line = line.gsub(/[\r\n]/, '')

        line =~ /^\s*(\d+)\s+(?:(@\S+@)|(\S+))(?:\s(.*))?$/ or raise "GEDCOM Syntax Error on line: '#{line}'"
        level = $1.to_i
        id = $2
        tag = $3
        data = $4

        if level <= @current_level
            (@current_level - level + 1).times {
                raise "bad level data on line #{line}" if @current_element.parent == nil
                @current_element = @current_element.parent
            }
        end

        if tag
            if tag == 'CONC' 
                @current_element.text += data if data
            elsif tag == 'CONT'
                @current_element.text += "\n#{data}" if data
            else
                element = XMElement.new(tag, nil, data)
                element.render
            end
        elsif id
            element = XMElement.new(data, id, nil)
            element.render
        else
            raise "Neither Tag nor ID were found on line: '#{line}'"
        end

        if element
            @current_element.add_element(element)
            @current_element = element
            @current_level = level
        end
    end

    def xml
        return @base_element.render
    end

    def clear
        @base_element = XMElement.new('gedcom', nil, nil)
        @current_element = @base_element
        @current_level = -1
    end
end
