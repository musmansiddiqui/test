clear
$req = $null
$req = Invoke-WebRequest -Uri http://alintacodingtest.azurewebsites.net/api/Movies -UseBasicParsing
    if($req.StatusDescription -ne "OK")
        {
            Write-host "Please check your web request"
            break
        }
        else
            {
            $json = $req.Content | ConvertFrom-Json 
            #$json
            $hash = @{}
            $output = ""
            $jsonsorted = $json | Sort-Object name

                foreach($item in $jsonsorted.roles)
                    {
            
                            if($item.actor -eq "" -or $null -or !$item.actor)
                                {
                                        $D = "NO ACTOR NAME RECEIVED FOR "+ $item.name
                                        $output = $output + "`n$D"
                                }
                                    else
                                    {
                                        $A = $item.actor
                                        $D = "ACTOR NAME " + $A
                                        $output = $output + "`n$D"
                                    }
                    $actorname = $item.actor

                    foreach($item2 in $jsonsorted.roles)
                        {
                            if($actorname -eq $item2.actor)
                                {
                                    #write-host "Name of the role is " $item2.name
                                    $B = $item2.name
                                    $C =  "`tROLE PLAYED " + $B +"`n"
                                    $output = "$output" + "`n$C"
                                    $ouput = "`n"
                                }
                        }
                    }
            Set-Content -path "$PSScriptRoot\output.txt" -Value $output
            #Removes duplicate entries 
            Get-Content "$PSScriptRoot\output.txt" | %{if($hash.$_ -eq $null){$_}; $hash.$_ = 1} > "$PSScriptRoot\newoutput.txt"
            Get-Content "$PSScriptRoot\newoutput.txt"
            Remove-Item -Path "$PSScriptRoot\newoutput.txt" -Force
            Remove-Item -Path "$PSScriptRoot\output.txt" -Force
        }
