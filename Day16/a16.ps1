$fil = ".\Day16\ina16.txt"
#$fil = ".\Day16\test16.txt"
$indata = get-content $fil

Class ScanEr{


    Part2($in){
        $validNo = @{}
        $scanmode = $false
        $validT = @{}
        $depart = @{}
        $poz = @{}
        $myTicket = @()
        $zum = 0
        $tc = 0
        $myTi = $false
        foreach($r in $in){
            #write-host $r
            if($scanmode){
                $valid = $true
                $tr = @()
                $td = $r.split(",")
                $td | %{
                    if(!$validNo.Contains([int]$_)){
                        $valid = $false
                    }else{
                        $tr += $_
                    }
                }
                if($valid){
                    $c = 0
                    $tr | %{
                        $poz[$c] += $_
                    }
                    $validT.add($tc,$tr);
                    $tc++
                }
            }elseif($myTi){
                $td = $r.split(",")
                $p = 0
                $td | %{
                    $myTicket += [int]$_
                    $poz.add{$p,@()}
                }
                $myTi = $false
            }
            elseif($r.contains(":")){
                #write-host "Start twerk "
                $data = $r.split(":")
                #write-host "Twerking " $data[0]
                if($data[0] -eq "nearby tickets"){$scanmode = $true}
                elseif($data[0] -eq "your ticket"){$myTi = $true}
                else{
                    if($data[0] -contains "departure"){
                        $depart.add($data[0],@{})
                        $dep = $true
                    }
                    #write-host "Twerking " $data[1]
                    $ds = $data[1].split("or")
                    $ds |%{
                        $span = $_.split("-")
                        #write-host "Twerking span " $span[0] " till " $span[1]
                        for([int]$i = $span[0];$i -le $span[1];$i++){
                            $validNo[$i] += 1
                            if($dep){$depart[$data[0]][$i] += 1} 
                        }
                    }
                }
            }
        }
        $pos = @()
        foreach($p in $poz.Keys){
            $poz[$p] | % {
                foreach($d in $depart.Keys){
                    $pos[$d] += $p
                    if($depart[$d].ContainsKey($_){
                        $pos[$p][$d] ++
                    }
                }
            }
        }
        
        for($i = 0;$i -lt $validT[0].count;$i++){
            $pos += 0
            foreach($ti int $validT.keys){
                if($validT[$ti][$i]
            }
        }

        write-host "Antal " $zum
    }

    Part1($in){
        $validNo = @{}
        $scanmode = $false
        $zum = 0
        foreach($r in $in){
            #write-host $r
            if($scanmode){
                $td = $r.split(",")
                $td | %{
                    if($validNo.Contains([int]$_)){
                        #write-host "Thiz ahizz " $_
                    }else{
                        #write-host "Thiz amizz " $_
                        #write-host  $validNo[$_]
                        $zum += $_
                    }
                }
            }
            elseif($r.contains(":")){
                #write-host "Start twerk "
                $data = $r.split(":")
                #write-host "Twerking " $data[0]
                if($data[0] -eq "nearby tickets"){$scanmode = $true}
                elseif($data[0] -eq "your ticket"){}
                else{
                    #write-host "Twerking " $data[1]
                    $ds = $data[1].split("or")
                    $ds |%{
                        $span = $_.split("-")
                        #write-host "Twerking span " $span[0] " till " $span[1]
                        for([int]$i = $span[0];$i -le $span[1];$i++){
                            $validNo[$i] += 1
                        }
                    }
                }
            }
            
        }

        write-host "Antal " $zum
    }

}

$scan = [ScanEr]::new()

$scan.Part1($indata)
