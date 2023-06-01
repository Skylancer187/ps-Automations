﻿<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2023 v5.8.220
	 Created on:   	4/20/2023 4:26 PM
	 Created by:   	Nelson, Matthew
	 Organization: 	Florida State University
	 Filename:     	Remove-SimpleMSLAPSLegacy.ps1
	===========================================================================
	.DESCRIPTION
		Removes MS LAPS Legacy if April '23 update is present on the host.
#>

$allowedOS = @("Windows 10", "Windows 11", "Windows Server 2019", "Windows Server 2022") # Valid OS Versions
$appName = "Local Administrator Password Solution" # Search for Application Name

# Get operating system information
$osName = (Get-CimInstance Win32_OperatingSystem).Caption

# Check if the OS is allowed
if ($allowedOS -like $osName)
{
	Write-Host "This script is only supported on Windows 10, Windows 11, Windows Server 2019, and Windows Server 2022."
	break
}
else
{
	# Uninstall the LAPS agent
	$uninstallString = Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.DisplayName -like "*$appName*" } | Select-Object -ExpandProperty UninstallString
	
	if ($uninstallString)
	{
		$uninstallString = $uninstallString.replace('MsiExec.exe /I', "")
		Write-Host "Uninstalling $appName"
		Write-Host "Uninstall String: $uninstallString"
		Start-Process "msiexec.exe" -ArgumentList "/x $uninstallString /qn"
		Write-Host "$appName has been uninstalled."
	}
	else
	{
		Write-Host "$appName is not installed on this computer."
	}
}


# SIG # Begin signature block
# MIImqQYJKoZIhvcNAQcCoIImmjCCJpYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCIyoAa+4kxXzMM
# UYW6D7o//MSk0iQilGLm7KXD2+FUAKCCILswggMFMIIB7aADAgECAhAfK8eaTYBL
# mULrraKbZnX5MA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMTCklUUy1QS0ktUlQw
# HhcNMTUxMjE0MTI1MTMwWhcNMzUxMjE0MTMwMTMwWjAVMRMwEQYDVQQDEwpJVFMt
# UEtJLVJUMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlWsp5JJIwV4R
# JzEgqTR9LRrVWJbRds/D2aDJK1o74bbeTp+Lr4tTt/JTNaApSqPE1geFZGAyJWQQ
# Uc5qW9ULH2ooP66DJ/fHOETUKlrpKTMy/63Y74rcaJJmmrVWuAq/QiRUp1FZ9snh
# y3LWYrMdIE7vtMtGWHg/aKKsrNXmTQk+8RkGaThc2x38jmw6e6xXMQivBcbgUaZT
# NfTVT5UZ+GVFxRKvo629Wl3ooZDWNM0Mzkeaky0JT917mDXqYezUChABWKw0wxGK
# xohcMmlwc7Gp1aInToX3x9Z8ssvWFlUrqjDRsz+xByw+lWvJpncTcTl1Zp0rnBxr
# fFLGboYlEwIDAQABo1EwTzALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAd
# BgNVHQ4EFgQUfRt1pL3PdSiE4+dJah9HjIxLMmUwEAYJKwYBBAGCNxUBBAMCAQAw
# DQYJKoZIhvcNAQELBQADggEBAISNjURl9bhN+A+IvlrGk1xiM4VlWxryPqyheZ/L
# 8uAGQGm2SYBgzl+EynC33G//1Nxx/Ezh1v9m2zM17FDaMBFvM1Z+//0TIWrVjj60
# PZKeT3l/jZlyg3app0RF2wva/kuO0Rpc22offbeWj3jBBWsfetWrf/WcuSoGLP/i
# hsGBVXatSPO4IvbpU7v/6jbajRHGa+GU0Mvz2hfMoe5fc4OWjNz2Dr+g079JrdlH
# k0ssyKpbU2DiXXQIPoe6UCFOY1Tmv/qd6oS4BoYGRnUPx7y+aLSGNaUe2W9dV/ji
# 3Q7io6i+3dte4MAunIWyIkigGs+++iTyOC2szKAXEuljUdYwggS2MIIDnqADAgEC
# AhM2AAAAAshhcEW5fFYUAAAAAAACMA0GCSqGSIb3DQEBCwUAMBUxEzARBgNVBAMT
# CklUUy1QS0ktUlQwHhcNMTUxMjE0MTMyNDIzWhcNMjUxMjE0MTMzNDIzWjBEMRMw
# EQYKCZImiZPyLGQBGRYDZWR1MRMwEQYKCZImiZPyLGQBGRYDZnN1MRgwFgYDVQQD
# Ew9mc3UtSVRTLVBLSS1TVUIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDbar1hmUO5ZqLMjnaW2tIb/D1J+l2i/KGJrqfTCBX5QDQYiX88rG2osZ6UHYAg
# SiaSW9/DOpQwMvl2BuBaiisP1svZYBuJgoU8CcGMQzfME6RWylIl5ck3InWkx0bh
# krgAC4m9/omJM8JKcB24eMLLAEuyzuuHIiYrfp7Ik0XyeqfTlnjd8/ZuSJM4jl+q
# XBYdeVJTVaHfkp14D2Z6iUjHg4UhOOJ8ebKVV9bSf3iZC9PykXj0CEYk0E2qBK1c
# 1vuE9fy0Gg177WmbBof4EWEc7ZX8pXj11kLEUSvCjJjfBnCL7fPYgJrvrfVusm02
# 2r50ZieGfZ+KwaVWFmRgu+VNAgMBAAGjggHOMIIByjAQBgkrBgEEAYI3FQEEAwIB
# ADAdBgNVHQ4EFgQU7oXURG6+4/E3NYWspy2mXp0w5EYwGQYJKwYBBAGCNxQCBAwe
# CgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0j
# BBgwFoAUfRt1pL3PdSiE4+dJah9HjIxLMmUwPQYDVR0fBDYwNDAyoDCgLoYsaHR0
# cDovL2l0cy1wa2ktc3ViL0NlcnRFbnJvbGwvSVRTLVBLSS1SVC5jcmwwgf0GCCsG
# AQUFBwEBBIHwMIHtMIGlBggrBgEFBQcwAoaBmGxkYXA6Ly8vQ049SVRTLVBLSS1S
# VCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMs
# Y249Y29uZmlndXJhdGlvbixkYz1mc3UsZGM9ZWR1P2NBQ2VydGlmaWNhdGU/YmFz
# ZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MEMGCCsGAQUFBzAC
# hjdodHRwOi8vaXRzLXBraS1zdWIvQ2VydEVucm9sbC9JVFMtUEtJLVJUX0lUUy1Q
# S0ktUlQuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQATUcfWf/KCS6qnYs71tEuA2dWX
# yGFmzjkrdLKEtsoGvcX73hXJ/Ssih6SpCgbX0gY+B9rT6CtoV6gAtUcLUO9nOBni
# Ps4R2PQUKc9GOM9jVJHYf6Qha4PK5NWqgCH4qZlqNpK/z4P6pK/VX/QWvvJYHV5E
# l+kCgSIP+eK4BFRU/mZBxWCF2lyGL//Og1rABRA8wKIgSS0zC1xg3YNJhZiQMgSQ
# wW4w5/36twwvgQ+xht5vNaKk6Jiu7Tm/KkPyaD7S6q4Xr0A9vRmMnq6R+3ciGr3h
# UpEZATNh4KGMUnkd1SmNgE6/5VY1BUrSG17lPsrrx05rPz56J7pE7D5i6E5xMIIF
# gzCCA2ugAwIBAgIORea7A4Mzw4VlSOb/RVEwDQYJKoZIhvcNAQEMBQAwTDEgMB4G
# A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNp
# Z24xEzARBgNVBAMTCkdsb2JhbFNpZ24wHhcNMTQxMjEwMDAwMDAwWhcNMzQxMjEw
# MDAwMDAwWjBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEG
# A1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCAiIwDQYJKoZI
# hvcNAQEBBQADggIPADCCAgoCggIBAJUH6HPKZvnsFMp7PPcNCPG0RQssgrRIxutb
# PK6DuEGSMxSkb3/pKszGsIhrxbaJ0cay/xTOURQh7ErdG1rG1ofuTToVBu1kZguS
# gMpE3nOUTvOniX9PeGMIyBJQbUJmL025eShNUhqKGoC3GYEOfsSKvGRMIRxDaNc9
# PIrFsmbVkJq3MQbFvuJtMgamHvm566qjuL++gmNQ0PAYid/kD3n16qIfKtJwLnvn
# vJO7bVPiSHyMEAc4/2ayd2F+4OqMPKq0pPbzlUoSB239jLKJz9CgYXfIWHSw1CM6
# 9106yqLbnQneXUQtkPGBzVeS+n68UARjNN9rkxi+azayOeSsJDa38O+2HBNXk7be
# svjihbdzorg1qkXy4J02oW9UivFyVm4uiMVRQkQVlO6jxTiWm05OWgtH8wY2SXcw
# vHE35absIQh1/OZhFj931dmRl4QKbNQCTXTAFO39OfuD8l4UoQSwC+n+7o/hbguy
# CLNhZglqsQY6ZZZZwPA1/cnaKI0aEYdwgQqomnUdnjqGBQCe24DWJfncBZ4nWUx2
# OVvq+aWh2IMP0f/fMBH5hc8zSPXKbWQULHpYT9NLCEnFlWQaYw55PfWzjMpYrZxC
# RXluDocZXFSxZba/jJvcE+kNb7gu3GduyYsRtYQUigAZcIN5kZeR1BonvzceMgfY
# FGM8KEyvAgMBAAGjYzBhMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/
# MB0GA1UdDgQWBBSubAWjkxPioufi1xzWx/B/yGdToDAfBgNVHSMEGDAWgBSubAWj
# kxPioufi1xzWx/B/yGdToDANBgkqhkiG9w0BAQwFAAOCAgEAgyXt6NH9lVLNnsAE
# oJFp5lzQhN7craJP6Ed41mWYqVuoPId8AorRbrcWc+ZfwFSY1XS+wc3iEZGtIxg9
# 3eFyRJa0lV7Ae46ZeBZDE1ZXs6KzO7V33EByrKPrmzU+sQghoefEQzd5Mr6155ws
# TLxDKZmOMNOsIeDjHfrYBzN2VAAiKrlNIC5waNrlU/yDXNOd8v9EDERm8tLjvUYA
# Gm0CuiVdjaExUd1URhxN25mW7xocBFymFe944Hn+Xds+qkxV/ZoVqW/hpvvfcDDp
# w+5CRu3CkwWJ+n1jez/QcYF8AOiYrg54NMMl+68KnyBr3TsTjxKM4kEaSHpzoHdp
# x7Zcf4LIHv5YGygrqGytXm3ABdJ7t+uA/iU3/gKbaKxCXcPu9czc8FB10jZpnOZ7
# BN9uBmm23goJSFmH63sUYHpkqmlD75HHTOwY3WzvUy2MmeFe8nI+z1TIvWfspA9M
# Rf/TuTAjB0yPEL+GltmZWrSZVxykzLsViVO6LAUP5MSeGbEYNNVMnbrt9x+vJJUE
# eKgDu+6B5dpffItKoZB0JaezPkvILFa9x8jvOOJckvB595yEunQtYQEgfn7R8k8H
# WV+LLUNS60YMlOH1Zkd5d9VUWx+tJDfLRVpOoERIyNiwmcUVhAn21klJwGW45hpx
# bqCo8YLoRT5s1gLXCmeDBVrJpBAwggZZMIIEQaADAgECAg0B7BySQN79LkBdfEd0
# MA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAt
# IFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4X
# DTE4MDYyMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowWzELMAkGA1UEBhMCQkUxGTAX
# BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGlt
# ZXN0YW1waW5nIENBIC0gU0hBMzg0IC0gRzQwggIiMA0GCSqGSIb3DQEBAQUAA4IC
# DwAwggIKAoICAQDwAuIwI/rgG+GadLOvdYNfqUdSx2E6Y3w5I3ltdPwx5HQSGZb6
# zidiW64HiifuV6PENe2zNMeswwzrgGZt0ShKwSy7uXDycq6M95laXXauv0SofEEk
# jo+6xU//NkGrpy39eE5DiP6TGRfZ7jHPvIo7bmrEiPDul/bc8xigS5kcDoenJuGI
# yaDlmeKe9JxMP11b7Lbv0mXPRQtUPbFUUweLmW64VJmKqDGSO/J6ffwOWN+BauGw
# bB5lgirUIceU/kKWO/ELsX9/RpgOhz16ZevRVqkuvftYPbWF+lOZTVt07XJLog2C
# NxkM0KvqWsHvD9WZuT/0TzXxnA/TNxNS2SU07Zbv+GfqCL6PSXr/kLHU9ykV1/kN
# XdaHQx50xHAotIB7vSqbu4ThDqxvDbm19m1W/oodCT4kDmcmx/yyDaCUsLKUzHvm
# Z/6mWLLU2EESwVX9bpHFu7FMCEue1EIGbxsY1TbqZK7O/fUF5uJm0A4FIayxEQYj
# GeT7BTRE6giunUlnEYuC5a1ahqdm/TMDAd6ZJflxbumcXQJMYDzPAo8B/XLukvGn
# Et5CEk3sqSbldwKsDlcMCdFhniaI/MiyTdtk8EWfusE/VKPYdgKVbGqNyiJc9gwE
# 4yn6S7Ac0zd0hNkdZqs0c48efXxeltY9GbCX6oxQkW2vV4Z+EDcdaxoU3wIDAQAB
# o4IBKTCCASUwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
# VR0OBBYEFOoWxmnn48tXRTkzpPBAvtDDvWWWMB8GA1UdIwQYMBaAFK5sBaOTE+Ki
# 5+LXHNbH8H/IZ1OgMD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
# L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyNjA2BgNVHR8ELzAtMCugKaAnhiVo
# dHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMEcGA1UdIARAMD4w
# PAYEVR0gADA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
# bS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQwFAAOCAgEAf+KI2VdnK0JfgacJC7rE
# uygYVtZMv9sbB3DG+wsJrQA6YDMfOcYWaxlASSUIHuSb99akDY8elvKGohfeQb9P
# 4byrze7AI4zGhf5LFST5GETsH8KkrNCyz+zCVmUdvX/23oLIt59h07VGSJiXAmd6
# FpVK22LG0LMCzDRIRVXd7OlKn14U7XIQcXZw0g+W8+o3V5SRGK/cjZk4GVjCqaF+
# om4VJuq0+X8q5+dIZGkv0pqhcvb3JEt0Wn1yhjWzAlcfi5z8u6xM3vreU0yD/RKx
# tklVT3WdrG9KyC5qucqIwxIwTrIIc59eodaZzul9S5YszBZrGM3kWTeGCSziRday
# zW6CdaXajR63Wy+ILj198fKRMAWcznt8oMWsr1EG8BHHHTDFUVZg6HyVPSLj1Qok
# UyeXgPpIiScseeI85Zse46qEgok+wEr1If5iEO0dMPz2zOpIJ3yLdUJ/a8vzpWuV
# HwRYNAqJ7YJQ5NF7qMnmvkiqK1XZjbclIA4bUaDUY6qD6mxyYUrJ+kPExlfFnbY8
# sIuwuRwx773vFNgUQGwgHcIt6AvGjW2MtnHtUiH+PvafnzkarqzSL3ogsfSsqh3i
# LRSd+pZqHcY8yvPZHL9TTaRHWXyVxENB+SXiLBB+gfkNlKd98rUJ9dhgckBQlSDU
# Q0S++qCV5yBZtnjGpGqqIpswggZoMIIEUKADAgECAhABSJA9woq8p6EZTQwcV7gp
# MA0GCSqGSIb3DQEBCwUAMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
# aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVzdGFtcGluZyBDQSAt
# IFNIQTM4NCAtIEc0MB4XDTIyMDQwNjA3NDE1OFoXDTMzMDUwODA3NDE1OFowYzEL
# MAkGA1UEBhMCQkUxGTAXBgNVBAoMEEdsb2JhbFNpZ24gbnYtc2ExOTA3BgNVBAMM
# MEdsb2JhbHNpZ24gVFNBIGZvciBNUyBBdXRoZW50aWNvZGUgQWR2YW5jZWQgLSBH
# NDCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAMLJ3AO2G1D6Kg3onKQh
# 2yinHfWAtRJ0I/5eL8MaXZayIBkZUF92IyY1xiHslO+1ojrFkIGbIe8LJ6TjF2Q7
# 2pPUVi8811j5bazAL5B4I0nA+MGPcBPUa98miFp2e0j34aSm7wsa8yVUD4CeIxIS
# E9Gw9wLjKw3/QD4AQkPeGu9M9Iep8p480Abn4mPS60xb3V1YlNPlpTkoqgdediMw
# /Px/mA3FZW0b1XRFOkawohZ13qLCKnB8tna82Ruuul2c9oeVzqqo4rWjsZNuQKWb
# EIh2Fk40ofye8eEaVNHIJFeUdq3Cx+yjo5Z14sYoawIF6Eu5teBSK3gBjCoxLEzo
# BeVvnw+EJi5obPrLTRl8GMH/ahqpy76jdfjpyBiyzN0vQUAgHM+ICxfJsIpDy+Jr
# k1HxEb5CvPhR8toAAr4IGCgFJ8TcO113KR4Z1EEqZn20UnNcQqWQ043Fo6o3znMB
# lCQZQkPRlI9Lft3LbbwbTnv5qgsiS0mASXAbLU/eNGA+vQIDAQABo4IBnjCCAZow
# DgYDVR0PAQH/BAQDAgeAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMB0GA1UdDgQW
# BBRba3v0cHQIwQ0qyO/xxLlA0krG/TBMBgNVHSAERTBDMEEGCSsGAQQBoDIBHjA0
# MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0
# b3J5LzAMBgNVHRMBAf8EAjAAMIGQBggrBgEFBQcBAQSBgzCBgDA5BggrBgEFBQcw
# AYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vY2EvZ3N0c2FjYXNoYTM4NGc0
# MEMGCCsGAQUFBzAChjdodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2Vy
# dC9nc3RzYWNhc2hhMzg0ZzQuY3J0MB8GA1UdIwQYMBaAFOoWxmnn48tXRTkzpPBA
# vtDDvWWWMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5j
# b20vY2EvZ3N0c2FjYXNoYTM4NGc0LmNybDANBgkqhkiG9w0BAQsFAAOCAgEALms+
# j3+wsGDZ8Z2E3JW2318NvyRR4xoGqlUEy2HB72Vxrgv9lCRXAMfk9gy8GJV9Lxlq
# YDOmvtAIVVYEtuP+HrvlEHZUO6tcIV4qNU1Gy6ZMugRAYGAs29P2nd7KMhAMeLC7
# VsUHS3C8pw+rcryNy+vuwUxr2fqYoXQ+6ajIeXx2d0j9z+PwDcHpw5LgBwwTLz9r
# fzXZ1bfub3xYwPE/DBmyAqNJTJwEw/C0l6fgTWolujQWYmbIeLxpc6pfcqI1WB4m
# 678yFKoSeuv0lmt/cqzqpzkIMwE2PmEkfhGdER52IlTjQLsuhgx2nmnSxBw9oguM
# iAQDVN7pGxf+LCue2dZbIjj8ZECGzRd/4amfub+SQahvJmr0DyiwQJGQL062dlC8
# TSPZf09rkymnbOfQMD6pkx/CUCs5xbL4TSck0f122L75k/SpVArVdljRPJ7qGugk
# xPs28S9Z05LD7MtgUh4cRiUI/37Zk64UlaiGigcuVItzTDcVOFBWh/FPrhyPyaFs
# Lwv8uxxvLb2qtutoI/DtlCcUY8us9GeKLIHTFBIYAT+Eeq7sR2A/aFiZyUrCoZkV
# BcKt3qLv16dVfLyEG02Uu45KhUTZgT2qoyVVX6RrzTZsAPn/ct5a7P/JoEGWGkBq
# hZEcr3VjqMtaM7WUM36yjQ9zvof8rzpzH3sg23IwggakMIIFjKADAgECAhNQAAFz
# FWTVbPcR7AU8AAAAAXMVMA0GCSqGSIb3DQEBCwUAMEQxEzARBgoJkiaJk/IsZAEZ
# FgNlZHUxEzARBgoJkiaJk/IsZAEZFgNmc3UxGDAWBgNVBAMTD2ZzdS1JVFMtUEtJ
# LVNVQjAeFw0yMjA5MDIyMjE1MTFaFw0yNTEyMTQxMzM0MjNaMIGdMRMwEQYKCZIm
# iZPyLGQBGRYDZWR1MRMwEQYKCZImiZPyLGQBGRYDZnN1MRswGQYDVQQLExJGU1Ug
# U2VydmljZSBBZG1pbnMxFzAVBgNVBAsTDkFkbWluIEFjY291bnRzMSUwIwYDVQQL
# ExxFbnRlcnByaXNlIFN5c0FkbWluIEFjY291bnRzMRQwEgYDVQQDEwthZG0tbWF0
# dGhldzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKHtA+be+EBSSEOR
# 3HL9Q9S1zHRAHXNCS8Z91yBbzGeOR1dQqmWUSNrn3bE7w9RQFKx2CSW9gON/Fhrw
# /TjYAlFNgahOYX8Lgg7syGLvveZGFe7MtI3iaEILUqEQUngbwZOVkQNmZicYSkwT
# k9gpzZiYDKN49UdnBQoYXrTYGyRbmDwg3oBXLip/4Kxyxztigw3v0dNjTDUOcbC0
# 0gkZlRrreOd/DCyY/Iqh517meLQQWtUKM2WZ6IRLfk45SgOrX22cXJLn9iqQF5Vm
# Eggc11l4iKFTLv+7sxkKS3+gXCxYSIwO59L4xQZS9/DZjKmEGh1blaKvgXe4dIvd
# Em1JO+kCAwEAAaOCAzMwggMvMD4GCSsGAQQBgjcVBwQxMC8GJysGAQQBgjcVCIWy
# 4GeB/KR3hMWPGoTwkzmB1OMHgV2F6cgyh+zySAIBZAIBCDATBgNVHSUEDDAKBggr
# BgEFBQcDAzALBgNVHQ8EBAMCB4AwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcD
# AzAuBgNVHREEJzAloCMGCisGAQQBgjcUAgOgFQwTYWRtLW1hdHRoZXdAZnN1LmVk
# dTAdBgNVHQ4EFgQUpiE7RK+bo0YKJlIRzdZD2dOxeo0wHwYDVR0jBBgwFoAU7oXU
# RG6+4/E3NYWspy2mXp0w5EYwgc0GA1UdHwSBxTCBwjCBv6CBvKCBuYaBtmxkYXA6
# Ly8vQ049ZnN1LUlUUy1QS0ktU1VCLENOPWl0cy1wa2ktc3ViLENOPUNEUCxDTj1Q
# dWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
# aW9uLERDPWZzdSxEQz1lZHU/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNl
# P29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MIIBGgYIKwYBBQUHAQEE
# ggEMMIIBCDCBqgYIKwYBBQUHMAKGgZ1sZGFwOi8vL0NOPWZzdS1JVFMtUEtJLVNV
# QixDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMs
# Q049Q29uZmlndXJhdGlvbixEQz1mc3UsREM9ZWR1P2NBQ2VydGlmaWNhdGU/YmFz
# ZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MFkGCCsGAQUFBzAC
# hk1odHRwOi8vaXRzLXBraS1zdWIuZnN1LmVkdS9DZXJ0RW5yb2xsL2l0cy1wa2kt
# c3ViLmZzdS5lZHVfZnN1LUlUUy1QS0ktU1VCLmNydDBQBgkrBgEEAYI3GQIEQzBB
# oD8GCisGAQQBgjcZAgGgMQQvUy0xLTUtMjEtMjA1MjExMTMwMi0xODk3MDUxMTIx
# LTcyNTM0NTU0My02Njc1MTcwDQYJKoZIhvcNAQELBQADggEBANBUInErh80i/xRT
# +h2bmkjNrzYEZKM5w69JhZ+TP9WvI6CpEb7iWyydIFmlMOsw+y/AfYRBxAjmMAcZ
# k2cjR3IJ9AT5CKcO03p+xbzUQ0bL1ukIksJ2is1uWqK4vLquUU/zVbjRqhy9e7UG
# iLoc+Zop7FWchtmRQIfIB5xzA1+gX5wwUeiopeWqg2L9WMWc8q+zUOnLAVeo3K9x
# 2V99kqPJyxu7L5eYc8EY4JT6GgHWT6sKr6VmAomnQY9mn38AhZJlJgZmafMyUuPL
# C3mv4msmtk/6Cf31riyiHWePRRAuNg4gDWgZqwQZuer86csuM2+qs1gyAQBS1pOR
# x9xJu+8xggVEMIIFQAIBATBbMEQxEzARBgoJkiaJk/IsZAEZFgNlZHUxEzARBgoJ
# kiaJk/IsZAEZFgNmc3UxGDAWBgNVBAMTD2ZzdS1JVFMtUEtJLVNVQgITUAABcxVk
# 1Wz3EewFPAAAAAFzFTANBglghkgBZQMEAgEFAKBMMBkGCSqGSIb3DQEJAzEMBgor
# BgEEAYI3AgEEMC8GCSqGSIb3DQEJBDEiBCC7dcFXBmT2evVHr0yUj42+Rc7afxFd
# uyTfAjo73FRmfjANBgkqhkiG9w0BAQEFAASCAQCZOSpmzWv4ddPgXsFojmUX/xeY
# iZkotChO5bJolHRVsaO3jxZd1qJLfabe2qIYqS62plbdVd0FGzari6gYLmMq2lfQ
# xZf5kaYFLe9qS4nd37N5vql+x+BKDflZTq2YWUAACYADYIkkIZu4HUqban5C0rgm
# RmFqn5ZeJN/xaR215j+CnfS/GfQzhWkUGIUKHao3mUqweACrwAqFKw4/s7kI0xhv
# Djx4FsE0kIkV8Dx7snR/uK/gflgrzMASaedgfCwNKLnaLotn49tjLJkK85RWirD6
# nj4dait/fmZLaY9CrvQKC8G5aCjJj9hskK8vErOJwSHHIVktrsIvh4YWIghOoYID
# bDCCA2gGCSqGSIb3DQEJBjGCA1kwggNVAgEBMG8wWzELMAkGA1UEBhMCQkUxGTAX
# BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGlt
# ZXN0YW1waW5nIENBIC0gU0hBMzg0IC0gRzQCEAFIkD3CirynoRlNDBxXuCkwCwYJ
# YIZIAWUDBAIBoIIBPTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
# DQEJBTEPFw0yMzA1MzExNTEwMDhaMCsGCSqGSIb3DQEJNDEeMBwwCwYJYIZIAWUD
# BAIBoQ0GCSqGSIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCDQ3hDikQmgLQcBwa0V
# IDvvZGC9YTfE5IZ3mZqDzwFuyTCBpAYLKoZIhvcNAQkQAgwxgZQwgZEwgY4wgYsE
# FDEDDhdqpFkuqyyLregymfy1WF3PMHMwX6RdMFsxCzAJBgNVBAYTAkJFMRkwFwYD
# VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIFRpbWVz
# dGFtcGluZyBDQSAtIFNIQTM4NCAtIEc0AhABSJA9woq8p6EZTQwcV7gpMA0GCSqG
# SIb3DQEBCwUABIIBgJ+d/3EjKLnRVMloIqk+5UM84V1jxp1EEzcgsgkb3LnrhNij
# giUeiv0FdS6b7NLgLTm3f3aZYWqkYttOzKmXrcJQRCX/j1KunzqRzuALPrBaPAva
# 0KciXpAaLNUKexv36mAXBuXDj2HAAlS5WVOALd72ltrTsPZYL6s4ln5jG9qbR3zk
# tFf1G5fRL/ozmVqy0sxocSu0gs4BPe09/aNNyG7UIx6vySy9zYnAS8b/HnGowC7c
# j3lawr4zk2z3Vzm1Z/EayRKkCdq8NT7qud6SFpzIio5nbsB8AUdyBCVGaXQNDaLk
# OanBont3dk7nZFiDjyQFxwRvYiGWbSzL8yQAakZSMrgqGvlGOeWInvEjdz0sNV0T
# +HKLCtIhF0D+nSBKeFLcJRVjTnsEAnX8CVOjKDMS5QOeW8N9F4Vbhi0EQ4194cJY
# jH+xrfYhKtOzltwe1jv/EJr8POFYZlTuLOu7NbPcYfwRvveG+/1ognKD7IA14dLG
# ncHcRf8ZxH1tcfJzQQ==
# SIG # End signature block
