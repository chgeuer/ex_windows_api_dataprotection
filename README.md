# :ex_windows_api_dataprotection

Download on [hex.pm/packages/ex_windows_api_dataprotection](https://hex.pm/packages/ex_windows_api_dataprotection).

> Access the Windows Data Protection API (DPAPI) from Elixir.

The [Microsoft Windows Data Protection API (DPAPI)](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/) features functions for encrypting/wrapping/protecting and decrypting/unwrapping/unprotecting data, namely [CryptProtectData](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata) and [CryptUnprotectData](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptunprotectdata). These functions are defined in `dpapi.h`. 

The following sample demonstrates it:

```elixir
import Windows.API.DataProtection, only: [wrap: 1, unwrap: 1]

"Hello world"
|> wrap()
|> unwrap()
```

returns `"Hello world"`.

## Why did I create this?

I needed access to the [Azure CLI's MSAL token cache](https://learn.microsoft.com/en-us/cli/azure/msal-based-azure-cli), which is in my user directory (`%USERPROFILE%\.azure\msal_token_cache.bin`). 

On Linux and MacOS, this token cache is an un-encrypted JSON file (`~/.azure/msal_token_cache.json`).

However, on Windows, it's protected / encrypted, using DPAPI. With this module, I can access the JSON contents by unwrapping, with such a script:

```elixir
Mix.install([
  {:ex_windows_api_dataprotection, "~> 0.1.1"}
])

"#{System.get_env("USERPROFILE")}\\.azure\\msal_token_cache.bin"
|> File.read!()
|> Windows.API.DataProtection.unwrap()
|> IO.puts()
```

