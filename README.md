# ex_windows_api_dataprotection
> Access the Windows Data Protection API (DPAPI) from Elixir.

The [Microsoft Windows Data Protection API (DPAPI)](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/) features functions for encrypting/wrapping/protecting and decrypting/unwrapping/unprotecting data, namely [CryptProtectData](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptprotectdata) and [CryptUnprotectData](https://learn.microsoft.com/en-us/windows/win32/api/dpapi/nf-dpapi-cryptunprotectdata). These functions are defined in `dpapi.h`. 
