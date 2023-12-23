defmodule Windows.API.DataProtection.MixProject do
  use Mix.Project

  @source_url "https://github.com/chgeuer/ex_windows_api_dataprotection"
  @version "0.1.1"
  @dev? String.ends_with?(@version, "-dev")
  @force_build? System.get_env("DPAPI_BUILD") in ["1", "true"]

  def project do
    [
      app: :ex_windows_api_dataprotection,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      docs: docs(),
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
      ],
      source_url: @source_url
    ]
  end

  defp description() do
    "A (Windows-specific) wrapper to access the Data Protection API (DPAPI)."
  end

  def application do
    [
      extra_applications: []
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:rustler_precompiled, "~> 0.7"},
      {:rustler, "~> 0.30.0", runtime: false, optional: not (@dev? or @force_build?)}
    ]
  end

  defp docs do
    [
      main: "Windows.API.DataProtection",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["demo.livemd"]
    ]
  end

  defp package do
    [
      name: "ex_windows_api_dataprotection",
      files: ~w(lib native checksum-*.exs mix.exs README.md LICENSE),
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => @source_url
      },
      maintainers: ["Dr. Christian Geuer-Pollmann"]
    ]
  end
end
