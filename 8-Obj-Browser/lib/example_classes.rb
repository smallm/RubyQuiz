class ExampleParent
    def initialize()
        @stuff = [ExampleChild.new(self), "yep"]
        @child = ExampleChild.new(self)
        @circularRef = self
    end
end

class ExampleChild
attr_accessor :a
    def initialize(parent)
        @s = "A string"
        @i = 1
        @u
        @n = nil
        @anotherCircularRef = parent
    end
end
