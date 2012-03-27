class XMElement
    attr_accessor :type, :value, :text, :elements, :parent

    def initialize(type, val, txt)
        @type = type
        @value = val
        @text = txt
        @elements = Array.new()
        @text = '' unless @text
    end

    def render
        xml = []
        xml.push("\n") if parent
        xml.push("<#{@type}#{" id = \"#{@value}\"" if @value}>#{@text}")
        @elements.each { |element|
            xml.push(element.render().gsub(/\n/, "\n\t" ))
        }
        xml.push("\n") unless @elements.empty?
        xml.push("</#{@type}>")
        return xml.join
    end

    def add_element(element)
        element.parent = self
        @elements.push(element)
    end
end
