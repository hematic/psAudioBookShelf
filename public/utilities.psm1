function Get-ABSAuthToken {

    <#
    .SYNOPSIS

    Function to Get authenticated to the ABS API

    .DESCRIPTION

    Function to Get an auth token from the ABS API. This function creates a global variable that contains
    both the auth token, headers, and the base_uri of the server for reference in all future functions.

    .PARAMETER username
    The name of the ABS account.

    .PARAMETER password
    The password of the ABS account.

    .PARAMETER base_uri
    The Base URL of the ABS server.

    .INPUTS

    None.

    .OUTPUTS

    None.

    .EXAMPLE

    Get-ABSAuthToken -username $user -password $pass -base_uri 'https://my.absserver.com'

    .LINK

   https://api.audiobookshelf.org/#authentication

    #>

    param (
        [Parameter(Mandatory = $true)]
        [string]$username,

        [Parameter(Mandatory = $true)]
        [string]$password,

        [Parameter(Mandatory = $true)]
        [string]$base_uri
    )

    begin{
        $body = @{
            username = $username
            password = $password
        } | ConvertTo-Json

        $endpoint = '/login'
        $uri = $base_uri + $endpoint
        $method = 'post'
        $ContentType = 'application/json'

        $Global:abs_auth = New-Object -TypeName pscustomobject -Property @{
            token = $null
            base_uri = $base_uri
            headers = $null
        }
    }

    process{
        Try{
            $response = Invoke-RestMethod -Uri $uri -Method $method -Body $body -ContentType $ContentType -ErrorAction Stop
            $Global:abs_auth.token = $response.user.token
            $Global:abs_auth.headers = @{
                Authorization = "Bearer $($response.user.token)"
            }
        }
        catch {
            Switch -Wildcard ($_.Exception.Response.StatusCode.value__) {
                '401' {Write-Error "Unauthorized. Invalid username or password."}
                default {Write-Error "HTTP: $_"}
            } 
        }
    }
}