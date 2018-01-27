
function Invoke-SWApiRequest {
    <#
        .SYNOPSIS
            Support function for the SWAPI module
        .DESCRIPTION
            This function does the actual restmethod call against the API
        .LINK
            https://github.com/rumart/SupportBeePS
            https://adatum.no
            https://rudimartinsen.com
        .NOTES
            Info
            Author: Rudi Martinsen / Intility AS and Martin Ehrnst / Intility AS
            Date: 16/01-2018
            Version: 0.2.0
            Revised: 27/01-2018
            Changelog:
            0.2.0 -- Retrieves all objects as the default
        .PARAMETER Resource
            The resource to work with, i.e. Films
        .PARAMETER Query
            The search term to query for
        .PARAMETER Uri
            The full URI of an API call
        .EXAMPLE
            Invoke-SWApiRequest -Resource "films"
            Retrieves all the films in the Star Wars Universe
        .EXAMPLE
            Invoke-SWApiRequest -Resource people -Query "skywalker"
            Searches for people with the name skywalker
    #>
    [CmdletBinding()]
    param(
        [parameter(ParameterSetName="Res")]
        $Resource,
        [parameter(ParameterSetName="Res")]
        $Query,
        [parameter(ParameterSetName="Uri")]
        $Uri,
        $Method = "GET"
    )
    $baseUrl = "https://swapi.co/api/"
    $output = @()

    if($Uri){
        Write-Verbose $uri
        $output = Invoke-RestMethod -Method $Method -Uri $uri
    }
    else{
        if($Query){
            $query = "?search=" + $query
        }
        $uri = $baseUrl + $Resource + "/" + $Query

        $response = Invoke-RestMethod -Method $Method -Uri $Uri
        if($response.next){
            while($response.next){
                Write-Verbose $response.results.count
                $output += $response.results
                $response = Invoke-RestMethod -Method $Method -Uri $response.next
                if(!$response.next){
                    $output += $response.results
                }
            }
        }
        else{
            $output = $response
        }
    }

    if($output.results -and $output -is [pscustomobject]){
        $output.results
    }
    else{
        $output
    }
    
}

function Get-SWAPIPeople {
    <#
        .SYNOPSIS
            Retrieve information about Star Wars people
        .DESCRIPTION
            This function retrieves information about the people in the Star Wars universe
            through the open https://swapi.co API
        .LINK
            https://github.com/rumart/SupportBeePS
            https://adatum.no
            https://rudimartinsen.com
        .NOTES
            Info
            Author: Rudi Martinsen / Intility AS and Martin Ehrnst / Intility AS
            Date: 16/01-2018
            Version: 0.2.0
            Revised: 27/01-2018
            Changelog:
            0.2.0 -- Adjusted to the new Invoke-SWAPIRequestmethod
        .PARAMETER Id
            Filter on the object with the specific Id
        .PARAMETER Query
            Use this parameter to query for (part of) a name
        .EXAMPLE
            Get-SWAPIPeople
            Retrieves all the people in the Star Wars Universe
        .EXAMPLE
            Get-SWAPIPeople -Id 1
            Retrieves the object with the Id 1
        .EXAMPLE
            Get-SWAPIPeople -Query "skywalker"
            Searches for people with the name skywalker
    #>
    [CmdletBinding()]
    param(
        [int]
        $Id,
        [string]
        $Query
    )

    $resource = "people"

    if($Id){
        $resource += "/" + $Id
    }


    $method = "GET"

    $response = Invoke-SWApiRequest -Method $method -Resource $resource -Query $Query
    $response
    
}

function Get-SWAPIPlanet {
    <#
        .SYNOPSIS
            Retrieve information about Star Wars planets
        .DESCRIPTION
            This function retrieves information about the planets in the Star Wars universe
            through the open https://swapi.co API
        .LINK
            https://github.com/rumart/SupportBeePS
            https://adatum.no
            https://rudimartinsen.com
        .NOTES
            Info
            Author: Rudi Martinsen / Intility AS and Martin Ehrnst / Intility AS
            Date: 16/01-2018
            Version: 0.2.0
            Revised: 27/01-2018
            Changelog:
            0.2.0 -- Adjusted to the new Invoke-SWAPIRequestmethod
        .PARAMETER Id
            Filter on the object with the specific Id
        .PARAMETER Query
            Use this parameter to query for (part of) a name
        .EXAMPLE
            Get-SWAPIPlanet
            Retrieves all the planets in the Star Wars Universe
        .EXAMPLE
            Get-SWAPIPlanet -Id 1
            Retrieves the object with the Id 1
        .EXAMPLE
            Get-SWAPIPlanet -Query "tatto"
            Searches for planets with the given name
    #>
    [CmdletBinding()]
    param(
        [int]
        $Id,
        [string]
        $Query
    )

    $resource = "planets"
    if($Id){
        $resource += "/" + $Id
    }

    $method = "GET"

    $response = Invoke-SWApiRequest -Method $method -Resource $resource -Query $Query
    $response
    
}

function Get-SWAPIVehicle {
    <#
        .SYNOPSIS
            Retrieve information about Star Wars vehicles
        .DESCRIPTION
            This function retrieves information about the vehicles in the Star Wars universe
            through the open https://swapi.co API
        .LINK
            https://github.com/rumart/SupportBeePS
            https://adatum.no
            https://rudimartinsen.com
        .NOTES
            Info
            Author: Rudi Martinsen / Intility AS and Martin Ehrnst / Intility AS
            Date: 16/01-2018
            Version: 0.2.0
            Revised: 27/01-2018
            Changelog:
            0.2.0 -- Adjusted to the new Invoke-SWAPIRequestmethod
        .PARAMETER Id
            Filter on the object with the specific Id
        .PARAMETER Query
            Use this parameter to query for (part of) a name
        .EXAMPLE
            Get-SWAPIVehicle
            Retrieves all the vehicles in the Star Wars Universe
        .EXAMPLE
            Get-SWAPIVehicle -Id 1
            Retrieves the object with the Id 1
        .EXAMPLE
            Get-SWAPIVehicle -Query "at"
            Searches for vehicles with the given name
    #>
    [CmdletBinding()]
    param(
        [int]
        $Id,
        [string]
        $Query
    )

    $resource = "vehicles"
    if($Id){
        $resource += "/" + $Id
    }

    $method = "GET"

    $response = Invoke-SWApiRequest -Method $method -Resource $resource -Query $Query 
    $response
}

function Get-SWAPIStarships {
    <#
        .SYNOPSIS
            Retrieve information about Star Wars starships
        .DESCRIPTION
            This function retrieves information about the starships in the Star Wars universe
            through the open https://swapi.co API
        .LINK
            https://github.com/rumart/SupportBeePS
            https://adatum.no
            https://rudimartinsen.com
        .NOTES
            Info
            Author: Rudi Martinsen / Intility AS and Martin Ehrnst / Intility AS
            Date: 16/01-2018
            Version: 0.2.0
            Revised: 27/01-2018
            Changelog:
            0.2.0 -- Adjusted to the new Invoke-SWAPIRequestmethod
        .PARAMETER Id
            Filter on the object with the specific Id
        .PARAMETER Query
            Use this parameter to query for (part of) a name
        .EXAMPLE
            Get-SWAPIStarships
            Retrieves all the starships in the Star Wars Universe
        .EXAMPLE
            Get-SWAPIStarships -Id 1
            Retrieves the object with the Id 1
        .EXAMPLE
            Get-SWAPIStarships -Query "falcon"
            Searches for starships with the given name
    #>
    [CmdletBinding()]
    param(
        [int]
        $Id,
        [string]
        $Query
    )

    $resource = "starships"
    if($Id){
        $resource += "/" + $Id
    }

    $method = "GET"

    $response = Invoke-SWApiRequest -Method $method -Resource $resource -Query $Query
    $response
    
}

function Get-SWAPIFilms {
    <#
        .SYNOPSIS
            Retrieve information about Star Wars episodes
        .DESCRIPTION
            This function retrieves information about the episodes in the Star Wars universe
            through the open https://swapi.co API
        .LINK
            https://github.com/rumart/SupportBeePS
            https://adatum.no
            https://rudimartinsen.com
        .NOTES
            Info
            Author: Rudi Martinsen / Intility AS and Martin Ehrnst / Intility AS
            Date: 16/01-2018
            Version: 0.2.0
            Revised: 27/01-2018
            Changelog:
            0.2.0 -- Adjusted to the new Invoke-SWAPIRequestmethod
        .PARAMETER Id
            Filter on the object with the specific Id
        .PARAMETER Query
            Use this parameter to query for (part of) a name
        .EXAMPLE
            Get-SWAPIFilms
            Retrieves all the episodes in the Star Wars Universe
        .EXAMPLE
            Get-SWAPIFilms -Id 1
            Retrieves the object with the Id 1
        .EXAMPLE
            Get-SWAPIFilms -Query "jedi"
            Searches for episodes with the given name
    #>
    [CmdletBinding()]
    param(
        [int]
        $Id,
        [string]
        $Query
    )

    $resource = "films"
    if($Id){
        $resource += "/" + $Id
    }

    $method = "GET"

    $response = Invoke-SWApiRequest -Method $method -Resource $resource -Query $Query
    $response
}

function Get-SWAPISpecies {
    <#
        .SYNOPSIS
            Retrieve information about Star Wars species
        .DESCRIPTION
            This function retrieves information about the species in the Star Wars universe
            through the open https://swapi.co API
        .LINK
            https://github.com/rumart/SupportBeePS
            https://adatum.no
            https://rudimartinsen.com
        .NOTES
            Info
            Author: Rudi Martinsen / Intility AS and Martin Ehrnst / Intility AS
            Date: 16/01-2018
            Version: 0.2.0
            Revised: 27/01-2018
            Changelog:
            0.2.0 -- Adjusted to the new Invoke-SWAPIRequestmethod
        .PARAMETER Id
            Filter on the object with the specific Id
        .PARAMETER Query
            Use this parameter to query for (part of) a name
        .EXAMPLE
            Get-SWAPISpecies
            Retrieves all the species in the Star Wars Universe
        .EXAMPLE
            Get-SWAPISpecies -Id 1
            Retrieves the object with the Id 1
        .EXAMPLE
            Get-SWAPISpecies -Query "human"
            Searches for species with the given name
    #>
    [CmdletBinding()]
    param(
        [int]
        $Id,
        [string]
        $Query
    )

    $resource = "species"
    if($Id){
        $resource += "/" + $Id
    }

    $method = "GET"

    $response = Invoke-SWApiRequest -Method $method -Resource $resource -Query $Query
    $response
}