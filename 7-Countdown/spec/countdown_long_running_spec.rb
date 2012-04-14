require 'countdown.rb'

describe Countdown do
    it "tries its best when there is no solution, bless its heart" do
        cd = Countdown.new(759, [25, 50, 75, 100, 1, 5])
        cd.findSolution.should eq('760 = ((75 + 1) x (50 / 5)) is closest to 760. It is off by 1.0')
    end
end

