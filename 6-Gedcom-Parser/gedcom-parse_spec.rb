require './gedcom-parse.rb'

describe GedParser do
    it "parses ids" do
        parser = GedParser.new
        parser.parseline('0 @I1@ INDI')
        parser.xml.should eq("<gedcom>\n\t<INDI id = \"@I1@\"></INDI>\n</gedcom>")
    end

    it "parses tags" do
        parser = GedParser.new
        parser.parseline('0 NAME Jamis Gordon /Buck/')
        parser.xml.should eq("<gedcom>\n\t<NAME>Jamis Gordon /Buck/</NAME>\n</gedcom>")
    end

    it "nests tags" do
        parser = GedParser.new
        parser.parseline('0 @I1@ INDI'               )
        parser.parseline('1 NAME Jamis Gordon /Buck/')
        parser.parseline('2 SURN Buck'               )
        parser.parseline('2 GIVN Jamis Gordon'       )
        parser.parseline('1 SEX M'                   )
        parser.xml.should eq("<gedcom>"+
                                "\n\t<INDI id = \"@I1@\">"+
                                    "\n\t\t<NAME>Jamis Gordon /Buck/"+
                                        "\n\t\t\t<SURN>Buck</SURN>"+
                                        "\n\t\t\t<GIVN>Jamis Gordon</GIVN>"+
                                    "\n\t\t</NAME>"+
                                    "\n\t\t<SEX>M</SEX>"+
                                "\n\t</INDI>"+
                            "\n</gedcom>")
    end

    it "appends CONC tags" do
        parser = GedParser.new
        parser.parseline('0   NOTE some text'       )
        parser.parseline('1     CONC more text'     )
        parser.parseline('1     CONC some more text')
        parser.xml.should eq("<gedcom>\n\t<NOTE>some textmore textsome more text</NOTE>\n</gedcom>")
    end

    it "appends CONT tags (with a newline)" do
        parser = GedParser.new
        parser.parseline('0   NOTE some text'       )
        parser.parseline('1     CONT more text'     )
        parser.parseline('1     CONT some more text')
        parser.xml.should eq("<gedcom>\n\t<NOTE>some text\n\tmore text\n\tsome more text</NOTE>\n</gedcom>")
    end
end
