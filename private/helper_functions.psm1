function New-DeviceQuery {
    Param (
        [Parameter(Mandatory = $True)]
        [hashtable]$search_params
    )
    Write-Debug "Entering Function: $($MyInvocation.MyCommand)"
    $queryComponents = @()

    If($search_params.keys -contains 'activation_date'){
        If(!$search_params.keys -contains $operator){
            Write-Error "When passing an activation date you must always pass an operator parameter."
        }
        switch ($search_params['operator']) {
            "Less Than" { $operatorSymbol = "<" }
            "Less Than Or Equal To" { $operatorSymbol = "<=" }
            "Greater Than" { $operatorSymbol = ">" }
            "Greater Than Or Equal To" { $operatorSymbol = ">=" }
        }
        $queryComponents += $("activationDate" + $operatorSymbol + $search_params['activation_date'])
    }

    If($search_params.keys -contains 'dynamics_container_id'){
        $queryComponents += $("dynamicsContainerId=" + $search_params['dynamics_container_id'])
    }

    If($search_params.keys -contains 'guid'){
        $queryComponents += $("guid=" + $search_params['guid'])
    }

    If($search_params.keys -contains 'imei'){
        $queryComponents += $("imei=" + $search_params['imei'])
    }

    If($search_params.keys -contains 'meid'){
        $queryComponents += $("meid=" + $search_params['meid'])
    }

    If($search_params.keys -contains 'ownership'){
        $queryComponents += $("ownership=" + $search_params['ownership'])
    }

    If($search_params.keys -contains 'udid'){
        $queryComponents += $("udid=" + $search_params['udid'])
    }

    If($search_params.keys -contains 'wifi_mac_address'){
        $queryComponents += $("wifiMacAddress=" + $search_params['wifi_mac_address'])
    }

    If($search_params.keys -contains 'shared_device_only'){
        $queryComponents += $("sharedDeviceOnly=" + $search_params['shared_device_only'])
    }

    If($search_params.keys -contains 'os'){
        $queryComponents += $("os=" + $search_params['os'])
    }

    If($search_params.keys -contains 'os_family_name'){
        $queryComponents += $("osFamilyName=" + $search_params['os_family_name'])
    }

    If($search_params.keys -contains 'hardware_model'){
        $queryComponents += $("hardwareModel=" + $search_params['hardware_model'])
    }

    If($search_params.keys -contains 'hardware_vendor_company_name'){
        $queryComponents += $("hardwareVendorCompanyName=" + $search_params['hardware_vendor_company_name'])
    }

    If($search_params.keys -contains 'enrollment_type'){
        $queryComponents += $("enrollmentType=" + $search_params['enrollment_type'])
    }

    $query_string = [String]::Join(",", $queryComponents)


    If($search_params.keys -contains 'include_total'){
        $query_string = $query_string + $("&includeTotal=" + $search_params['include_total'])
    }

    If($search_params.keys -contains 'max'){
        $query_string = $query_string + $("&max=" + $search_params['max'])
    }

    If($search_params.keys -contains 'offset'){
        $query_string = $query_string +$("&offset=" + $search_params['offset'])
    }

    Write-Output $query_string
}
