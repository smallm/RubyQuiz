require_relative 'obj_tree.rb'
require 'highline/system_extensions'
include HighLine::SystemExtensions

class ObjBrowser
    attr_accessor :tree
    attr_reader :currentNode

    def initialize(obj)
        @tree = ObjTreeNode.new(obj)
        @currentNode = @tree
    end

    def render()
        system 'clear'
        _render(@tree, 0)
    end

    def run()
        continue = true
        while continue
            render()
            input = get_character
            
            if(input == 107)    #j -- up
                _moveUp
            elsif(input == 106) #k -- down
                _moveDown
            elsif(input == 104) #h -- left
                _moveLeft
            elsif(input == 108 or input == 13) #l/enter -- right
                _moveRight
            elsif(input == 27) #a terrible way of detecting esc
                continue = false
            end
        end
    end

    protected
    def _render(node, tablevel)
        tabs = node == @currentNode ? '*' : ''
        tablevel.times do
            tabs += '    '
        end

        puts "#{tabs}#{node.name}#{node.name ? ' ' : ''}(#{node.type}):#{node.object.object_id}"

        if(node.expanded)
            node.children.each do |child|
                _render(child, tablevel + 1)
            end
        end
    end

    def _moveUp
        if @currentNode.parent == nil
            return
        elsif @currentNode.index == 0
            @currentNode = @currentNode.parent
        else
            @currentNode = @currentNode.parent.children[@currentNode.index - 1]
        end
    end

    def _moveDown
        if @currentNode.expanded and @currentNode.children.size > 0
            @currentNode = @currentNode.children[0]
        elsif @currentNode.parent == nil
            return
        elsif @currentNode.parent.children.size == @currentNode.index + 1
            return if @currentNode.parent.parent == nil or @currentNode.parent.parent.children.size == @currentNode.parent.index + 1
            @currentNode = @currentNode.parent
            @currentNode = @currentNode.parent.children[@currentNode.index + 1]
        else
            @currentNode = @currentNode.parent.children[@currentNode.index + 1]
        end
    end

    def _moveLeft
        @currentNode = @currentNode.parent unless @currentNode.parent == nil or @currentNode.expanded
        @currentNode.expanded = false
    end

    def _moveRight
        @currentNode.expanded = true
    end
end
