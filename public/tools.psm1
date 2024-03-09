function New-M4BencodeRequest {
    
    param (
        [Parameter(Mandatory = $true)]
        [string]$bookId,
        [Parameter(Mandatory = $false)]
        [string]$bitrate = '64k',
        [Parameter(Mandatory = $false)]
        [string]$codec = 'aac',
        [Parameter(Mandatory = $false)]
        [int]$channels = 2
    )

    begin{
        $headers = $global:abs_auth.headers
        $uri = $Global:abs_auth.base_uri + "/api/tools/item/$bookID/encode-m4b&bitrate=$bitrate&codec=$codec&channels=$channels"
        $method = 'post'
    }

    process{
        Try {
            $request = Invoke-RestMethod -Uri $uri -Method $method -Headers $headers -ErrorAction Stop
            return $request
        }
        catch {
            Switch -Wildcard ($_.Exception.Response.StatusCode.value__) {
                '403' {Write-Error "The user is not allowed to access the library item, or an admin user is required to make an .m4b file."}
                '404' {Write-Error "No library item with the given ID exists, or the library item has missing or invalid files."}
                '500' {Write-Error "The library item is not a book, or does not have audio tracks."}
                default {Write-Error "HTTP: $_"}
            } 
        }
    }
}