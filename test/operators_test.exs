defmodule OperatorsTest do
  use ExUnit.Case, async: true

  test "#Matrex.Operators defines shortcuts for common math functions" do
    m = Matrex.random(9, 20)

    Matrex.math_functions_list()
    |> Enum.each(fn f ->
      assert Kernel.apply(Matrex.Operators, f, [m]) == Matrex.apply(m, f)
    end)
  end

  test "#redefines math operators for working with matrices" do
    import Matrex.Operators
    import Kernel, except: [-: 1, +: 2, -: 2, *: 2, /: 2, <|>: 2]

    a = Matrex.random(5, 8)
    b = Matrex.reshape(1..40, 5, 8)
    c = Matrex.magic(8)

    expected = Matrex.add(a, b, 1.5, 2.3) |> Matrex.divide(23) |> Matrex.dot(c)

    assert (1.5 * a + 2.3 * b) / 23 * c == expected
  end
end
