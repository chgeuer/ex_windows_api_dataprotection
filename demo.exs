Mix.install([
  {:ex_windows_api_dataprotection, "~> 0.1.2"}
])

"Hello" |> Windows.API.DataProtection.wrap() |> Windows.API.DataProtection.unwrap()
