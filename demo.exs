Mix.install([
  {:ex_windows_api_dataprotection,
    git: "https://github.com/chgeuer/ex_windows_api_dataprotection.git",
    tag: "v0.1.0"}
])

import Windows.API.DataProtection, only: [wrap: 1, unwrap: 1]

"Hello" |> wrap() |> unwrap()
