defmodule RpnTest do
  use ExUnit.Case
  doctest Rpn

  test "calculates expression" do
    expression = "15 7 1 1 + - / 3 * 2 1 1 + + -"
    assert Rpn.calculate(expression) == 5
  end

  describe "calculate/2" do
    test "1 1 +" do
      expression = "1 1 +"
      assert Rpn.calculate(expression) == 2
    end

    test "5 4 -" do
      expression = "5 4 -"
      assert Rpn.calculate(expression) == 1
    end

    test "10 2 /" do
      expression = "10 2 /"
      assert Rpn.calculate(expression) == 5
    end

    test "8 3 *" do
      expression = "8 3 *"
      assert Rpn.calculate(expression) == 24
    end
  end
end
