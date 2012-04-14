class Expression
    attr_reader :value, :consistsOf

    def initialize(value, consistsOf)
        @value = value
        @consistsOf = consistsOf
    end

    def getBaseNumbersUsed()
        return [value] unless @consistsOf

        vals = @consistsOf.lNode.getBaseNumbersUsed()
        @consistsOf.rNode.getBaseNumbersUsed().each{ |val|
            vals.push(val)
        }
        return vals
    end

    def print
        return "#{@value}" unless @consistsOf

        return "(#{@consistsOf.lNode.print()} #{@consistsOf.op} #{@consistsOf.rNode.print()})"
    end
end

class Operation
    attr_accessor :lNode, :rNode, :op

    def initialize(lval, op, rval)
        @lNode = lval
        @op = op
        @rNode = rval
    end

end
