require 'countdown.rb'

describe Countdown do
    it "instantiates itself and doesn't afraid of anything" do
        cd = Countdown.new(522, [100, 5, 5, 2, 6, 8])
        cd.target.should eq(522)
        cd.cachedNumbers[2].value.should eq(2)
        cd.cachedNumbers[2].consistsOf.should eq(nil)
        cd.cachedNumbers[2].getBaseNumbersUsed.should eq([2])
        cd.cachedNumbers.size.should eq(5)
        cd.baseNumbers[5].should eq(2)
    end


    it "can find a solution" do
        cd = Countdown.new(522, [100, 5, 5, 2, 6, 8])
        cd.findSolution.should eq('522 = (((6 + 100) - (8 / 5)) x 5)')
    end
end
