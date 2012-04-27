class ObjTreeNode
    attr_reader :object, :name, :type, :parent, :index
    attr_accessor :expanded

    def initialize(obj, name = nil, parent = nil, index = 0)
        @object = obj
        @name = name
        @type = obj.class
        @parent = parent
        @children = nil
        @index = index
        @expanded = false
    end

    def children()
        return @children if @children

        @children = Array.new

        i = 0
        if object.is_a? Enumerable
            object.each do |element|
                @children << ObjTreeNode.new(element, nil, self, i)
                i += 1
            end
        else
            object.instance_variables.each do |name|
                @children << ObjTreeNode.new(object.instance_variable_get(name), name, self, i)
                i += 1
            end
        end

        return @children
    end
end
