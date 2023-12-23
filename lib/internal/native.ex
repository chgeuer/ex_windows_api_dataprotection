defmodule Windows.API.DataProtection.Native do
  @moduledoc false

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]
  mode = if Mix.env() in [:dev, :test], do: :debug, else: :release

  # use Rustler,
  #   otp_app: :ex_windows_api_dataprotection,
  #   crate: "ex_windows_api_dataprotection_rustler"

  use RustlerPrecompiled,
    otp_app: :ex_windows_api_dataprotection,
    version: version,
    base_url: "#{github_url}/releases/download/v#{version}",
    targets: ~w(
      x86_64-pc-windows-msvc
      x86_64-pc-windows-gnu
    ),
    # We don't use any features of newer NIF versions, so 2.15 is enough.
    nif_versions: ["2.15"],
    mode: mode

  # force_build: System.get_env("EXPLORER_BUILD") in ["1", "true"]

  def nif_wrap(_cleartext_bytes), do: :erlang.nif_error(:nif_not_loaded)

  def nif_unwrap(_ciphertext_bytes), do: :erlang.nif_error(:nif_not_loaded)
end
