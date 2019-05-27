defmodule Rpn do
  @moduledoc """
  Reverse polish notation calculator
  """

  @supported_operators ["+", "-", "/", "*"]

  @doc """
  Returns the expression calculated in reverse polish notation.

  Algorithm:

    for each token in the postfix expression:
    if token is an operator:
      operand_2 ← pop from the stack
      operand_1 ← pop from the stack
      result ← evaluate token with operand_1 and operand_2
      push result back onto the stack
    else if token is an operand:
      push token onto the stack
  result ← pop from the stack
  """
  @spec calculate(expression :: String.t()) :: any
  def calculate(expression) do
    {result, _} =
      expression
      |> String.split(" ")
      |> Enum.reduce([], &handle_token/2)
      |> pop()

    result
  end

  def handle_token(token, stack) when token in @supported_operators do
    {op2, stack} = pop(stack)
    {op1, stack} = pop(stack)

    result =
      token
      |> operator_fn()
      |> apply([op1, op2])

    [result | stack]
  end

  def handle_token(token, stack), do: [String.to_integer(token) | stack]

  def pop([]), do: {:error, []}
  def pop([op | rest]), do: {op, rest}

  def add(op1, op2), do: op1 + op2
  def subtract(op1, op2), do: op1 - op2
  def divide(op1, op2), do: div(op1, op2)
  def multiply(op1, op2), do: op1 * op2

  def operator_fn("+"), do: &add/2
  def operator_fn("-"), do: &subtract/2
  def operator_fn("/"), do: &divide/2
  def operator_fn("*"), do: &multiply/2
  def operator_fn(op), do: raise("Unsupported operator: #{inspect(op)}")
end
