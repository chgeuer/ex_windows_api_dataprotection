defmodule Windows.API.DataProtection.MixProject do
  use Mix.Project

  @source_url "https://github.com/chgeuer/ex_windows_api_dataprotection"
  @version "0.1.0"
  @dev? String.ends_with?(@version, "-dev")
  @force_build? System.get_env("DPAPI_BUILD") in ["1", "true"]

  def project do
    [
      app: :ex_windows_api_dataprotection,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: [
        "rust.lint": [
          "cmd cargo clippy --manifest-path=native/ex_windows_api_dataprotection/Cargo.toml -- -Dwarnings"
        ],
        "rust.fmt": [
          "cmd cargo fmt --manifest-path=native/ex_windows_api_dataprotection/Cargo.toml --all"
        ]
        # "localstack.setup": ["cmd ./test/support/setup-localstack.sh"],
        # ci: ["format", "rust.fmt", "rust.lint", "test"]
      ]
    ]
  end

  def application do
    [
      extra_applications: []
    ]
  end

  defp deps do
    [
      {:rustler_precompiled, "~> 0.7"},
      # {:rustler, "~> 0.30.0", runtime: false},
      {:rustler, "~> 0.30.0", optional: not (@dev? or @force_build?)}
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native",
        "checksum-*.exs",
        "mix.exs",
        "README.md",
        "LICENSE"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url},
      maintainers: ["Christian Geuer-Pollmann"]
    ]
  end
end
