require_relative 'obj_browser.rb'
require_relative 'example_classes.rb'

obj = ExampleParent.new
browser = ObjBrowser.new(obj)
browser.run()
