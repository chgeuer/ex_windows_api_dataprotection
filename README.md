# :ex_windows_api_dataprotection

Download on [hex.pm/packages/ex_windows_api_dataprotection](https://hex.pm/packages/ex_windows_api_dataprotection).

> Access the Windows Data Protection API (DPAPI) from Elixir. 

The [Microsoft Windows Data Protection API (DPAPI)](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/) features functions for encrypting/wrapping/protecting and decrypting/unwrapping/unprotecting data, namely [CryptProtectData](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata) and [CryptUnprotectData](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptunprotectdata). These functions are defined in `dpapi.h`. 

> The DPAPI on Windows is similar to other mechanisms, such as KeyChain on MacOS. The difference certainly is that DPAPI only takes care of encryption/decryption, and the user supplies the plaintext or ciphertext. Under the hood, Windows stores key material in the Windows registry, so that only *the currently logged-in user*, *on the current machine*, can decrypt the data encrypted by that user on that machine.

The following sample demonstrates it:

```elixir
import Windows.API.DataProtection, only: [wrap: 1, unwrap: 1]

"Hello world"
|> wrap()
|> unwrap()
```

returns `"Hello world"`.

## Scenario: Why did I create this?

I needed access to the [Azure CLI's MSAL token cache](https://learn.microsoft.com/en-us/cli/azure/msal-based-azure-cli), which is in my user directory (`%USERPROFILE%\.azure\msal_token_cache.bin`). 

On Linux and MacOS, this token cache is an un-encrypted JSON file (`~/.azure/msal_token_cache.json`).

However, on Windows, it's protected / encrypted, using DPAPI. With this module, I can access the JSON contents by unwrapping, with such an Elixir script:

```elixir
Mix.install([
  {:ex_windows_api_dataprotection, "~> 0.1.2"}
])

[System.user_home!(), ".azure", "msal_token_cache.bin"]
|> Path.join
|> File.read!()
|> Windows.API.DataProtection.unwrap()
|> IO.puts()
```

## Marketing 😜

Thanks to @brainlid, @dbern-stripe, and @cadebward for featuring this little library in the ["Thinking Elixir podcast / Magic Links episode 184](https://podcast.thinkingelixir.com/184), starting at minute 4:04...
