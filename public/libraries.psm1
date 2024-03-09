function Get-ABSLibraries {
    
    <#
    .SYNOPSIS

    Function to Get library information from the ABS API.

    .DESCRIPTION

    Function to get either a list of all libraries, or one specific library reference by id.

    .PARAMETER libraryId
    
    (Optional) The guid of the library you want to return. Leaving this off returns all existing libraries.

    .INPUTS

    None.

    .OUTPUTS

    PSCustomObject

    .EXAMPLE

    $libraries = Get-ABSLibraries

    .EXAMPLE 
    
    $specific_library = Get-ABSLibraries -libraryID 'fa6c931e-b34e-48b4-a7e6-b69a7f01666e'

    .LINK

    https://api.audiobookshelf.org/#get-all-libraries
    https://api.audiobookshelf.org/#get-a-library
    #>
    
    param (
        [Parameter(Mandatory = $false)]
        [string]$libraryId = $null
    )
    begin{
        $headers = $global:abs_auth.headers
        $uri = $Global:abs_auth.base_uri + '/api/libraries'
        if ($libraryId -ne $null) {
            $uri = "$uri/$libraryId"
        }

        $method = 'get'
    }

    process{
        Try {
            $libraries = Invoke-RestMethod -Uri $uri -Method $method -Headers $headers -ErrorAction Stop
            return $libraries
        }
        catch {
            Switch -Wildcard ($_.Exception.Response.StatusCode.value__) {
                '404' {Write-Error "The user cannot access the library, or no library with the provided ID exists."}
                default {Write-Error "HTTP: $_"}
            } 
        }
    }
}

function Get-ABSLibraryitems {
    param (
        [Parameter(Mandatory = $true)]
        [string]$libraryId,
        [Parameter(Mandatory = $false)]
        [int]$limit,
        [Parameter(Mandatory = $false)]
        [int]$page,
        [Parameter(Mandatory = $false)]
        [string]$sort,
        [Parameter(Mandatory = $false)]
        [bool]$desc,
        [Parameter(Mandatory = $false)]
        [string]$filter,
        [Parameter(Mandatory = $false)]
        [bool]$minified,
        [Parameter(Mandatory = $false)]
        [bool]$collapseseries,
        [Parameter(Mandatory = $false)]
        [string]$include

    )

    begin{
        $headers = $global:abs_auth.headers
        $uri = $Global:abs_auth.base_uri + "/api/libraries/$libraryId/items"
        $method = 'get'
    }

    process{
        Try {
            $library_items = Invoke-RestMethod -Uri $uri -Method $method -Headers $headers -ErrorAction Stop
            return $libraries
        }
        catch {
            Switch -Wildcard ($_.Exception.Response.StatusCode.value__) {
                '404' {Write-Error "The user cannot access the library, or no library with the provided ID exists."}
                default {Write-Error "HTTP: $_"}
            } 
        }
    }

}
