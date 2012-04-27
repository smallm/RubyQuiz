require 'obj_tree.rb'
require 'example_classes.rb'

describe ObjTreeNode do
    it "can find children of the object it's created for" do
        obj = ExampleParent.new
        tree = ObjTreeNode.new(obj)

        tree.type.should eq ExampleParent

        tree.children[0].name.should eq :@stuff
        tree.children[1].name.should eq :@child
        tree.children[2].name.should eq :@circularRef
        tree.children[2].type.should eq ExampleParent

        tree.children[0].children[0].name.should eq nil
        tree.children[0].children[1].name.should eq nil
        tree.children[0].children[0].type.should eq ExampleChild
        tree.children[0].children[1].object.should eq 'yep'

        tree.children[1].children[0].name.should eq :@s
        tree.children[1].children[1].name.should eq :@i
        tree.children[1].children[2].name.should eq :@n
        tree.children[1].children[3].name.should eq :@anotherCircularRef
        tree.children[1].children[0].object.should eq 'A string'
        tree.children[1].children[1].object.should eq 1
        tree.children[1].children[2].object.should eq nil
        tree.children[1].children[3].type.should eq ExampleParent
    end
end
