require 'expression.rb'

class Countdown
    attr_reader :target, :cachedNumbers, :baseNumbers

    def initialize(target, sourceNumbers)
        @target = target.to_f
        @cachedNumbers = Hash.new()
        @baseNumbers = Hash.new()
        sourceNumbers.each{ |n|
            if(@baseNumbers[n])
                @baseNumbers[n] += 1
            else
                @baseNumbers[n] = 1
                @cachedNumbers[n] = Expression.new(n, nil)
            end
        }
    end

    def findSolution()
        while(true)
            if(@cachedNumbers[@target])
                return "#{@target.to_i} = #{@cachedNumbers[@target].print()}"
            else
                prevNums = @cachedNumbers.keys()
                findMoreNumbers()
                if(prevNums == @cachedNumbers.keys())
                    return noSolution()
                end
            end
        end
    end

    def findMoreNumbers()
        newNumbers = Hash.new()
        @cachedNumbers.each{ |key1, num1|
            @cachedNumbers.each{ |key2, num2|
                moreNumbers = combine(num1, num2)
                newNumbers.update(moreNumbers) if moreNumbers
            }
        }
        @cachedNumbers.update(newNumbers);
    end

    def combine(num1, num2)
        bases = num1.getBaseNumbersUsed()
        bases.concat(num2.getBaseNumbersUsed())
        basefreq = bases.group_by{ |x| x }
        basefreq.each{ |number, instances|
            return nil if instances.size() > @baseNumbers[number]
        }

        newNumbers = Hash.new()

        #+
        result = num1.value.to_f + num2.value
        unless (@cachedNumbers[result])
            newNumbers[result] = Expression.new(result, Operation.new(num1, '+', num2))
        end
        #x
        result = num1.value.to_f * num2.value
        unless (@cachedNumbers[result])
            newNumbers[result] = Expression.new(result, Operation.new(num1, 'x', num2))
        end
        #-
        result = num1.value.to_f - num2.value
        unless (result <= 0 or @cachedNumbers[result])
            newNumbers[result] = Expression.new(result, Operation.new(num1, '-', num2))
        end
        result = num2.value.to_f - num1.value
        unless (result <= 0 or @cachedNumbers[result])
            newNumbers[result] = Expression.new(result, Operation.new(num2, '-', num1))
        end
        #/
        result = nil
        result = num1.value.to_f / num2.value unless num2.value == 0
        unless (!result or result < 0 or @cachedNumbers[result])
            newNumbers[result] = Expression.new(result, Operation.new(num1, '/', num2))
        end
        result = num2.value.to_f / num1.value unless num1.value == 0
        unless (!result or result < 0 or @cachedNumbers[result])
            newNumbers[result] = Expression.new(result, Operation.new(num2, '/', num1))
        end

    return newNumbers
    end

    def noSolution()
        difference = 1.0/0.0
        best = nil
        @cachedNumbers.each { |num, node|
            diff = (target - num).abs()
            if (diff < difference)
                difference = diff
                best = num
            end
        }
        return "#{best.to_i} (#{@cachedNumbers[best].print()}) is closest to #{@target.to_i}. It is off by #{difference}"
    end
end
