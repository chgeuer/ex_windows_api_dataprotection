defmodule Windows.API.DataProtection do
  @doc """
  Wraps a binary for the given user.

  ## Examples

    ```elixir
    iex> "some confidential input value"
    ...> |> wrap()
    ...> |> byte_size()
    ...> |> (fn length -> length > 0 end).()
    true
    ```
  """
  def wrap(binary) when is_binary(binary) do
    Windows.API.DataProtection.Native.nif_wrap(binary)
  end

  @doc """
  Unwraps a binary for the given user.

  ## Examples

    Demonstration of the round-trip property:

    ```elixir
    iex> "some confidential input value"
    ...> |> wrap()   # encrypt/wrap
    ...> |> unwrap() # decrypt/unwrap
    "some confidential input value"
    ```

  """
  def unwrap(binary) when is_binary(binary) do
    Windows.API.DataProtection.Native.nif_unwrap(binary)
  end
end
