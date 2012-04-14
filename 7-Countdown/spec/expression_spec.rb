require 'expression.rb'

describe Expression do
    it "can get its constituent base numbers" do
        basenode = Expression.new(522,
            Operation.new(
                Expression.new(500,
                    Operation.new(
                        Expression.new(100, nil), 'x', Expression.new(5, nil)
                    )
                ),
                '+',
                Expression.new(22,
                    Operation.new(
                        Expression.new(11,
                            Operation.new(
                                Expression.new(5, nil), '+', Expression.new(6, nil)
                            )
                        ),
                        'x',
                        Expression.new(2, nil)
                    )
                )
            )
        )

        basenode.getBaseNumbersUsed().should eq ([100, 5, 5, 6, 2])
    end

    it "can print itself" do
        basenode = Expression.new(522,
            Operation.new(
                Expression.new(500,
                    Operation.new(
                        Expression.new(100, nil), 'x', Expression.new(5, nil)
                    )
                ),
                '+',
                Expression.new(22,
                    Operation.new(
                        Expression.new(11,
                            Operation.new(
                                Expression.new(5, nil), '+', Expression.new(6, nil)
                            )
                        ),
                        'x',
                        Expression.new(2, nil)
                    )
                )
            )
        )

        basenode.print().should eq ('((100 x 5) + ((5 + 6) x 2))')
    end
end
