$fil = ".\Day12\ina12.txt"
#$fil = ".\Day12\test12.txt"

$indata = get-content $fil


class Ship{

    $data
    $dir
    $lat
    $long

    Ship($in){
        $this.data = $in
    }
    
    Part1(){
        $this.dir = 90
        foreach($r in $this.data){
            switch($r.substring(0,1)){
                "N"{$this.lat += [int]$r.substring(1)}
                "S"{$this.lat -= [int]$r.substring(1)}
                "E"{$this.long += [int]$r.substring(1)}
                "W"{$this.long -= [int]$r.substring(1)}
                "L"{$this.dir -= [int]$r.substring(1);if($this.dir -gt 350){$this.dir -= 360}elseif($this.dir -lt 0){$this.dir += 360}}
                "R"{$this.dir += [int]$r.substring(1);if($this.dir -gt 350){$this.dir -= 360}elseif($this.dir -lt 0){$this.dir += 360}}
                "F"{switch ($this.dir){
                    0{$this.lat += [int]$r.substring(1)}
                    90{$this.long += [int]$r.substring(1)}
                    180{$this.lat -= [int]$r.substring(1)}
                    270{$this.long -= [int]$r.substring(1)}
                }}
            }
            #write-host " Kan det vara " $this.lat + $this.long  " Åt " $this.dir
        }
        if($this.lat -lt 0){
            $this.lat = -$this.lat
        }
        if($this.long -lt 0){
            $this.long = -$this.long
        }
        
        write-host "Kan det vara "($this.lat + $this.long)
    }

    Part2(){
        $this.dir = 90
        $posLon= 0
        $posLat = 0
        $this.lat = 1
        $this.long = 10
        foreach($r in $this.data){
            switch($r.substring(0,1)){
                "N"{$this.lat += [int]$r.substring(1)}
                "S"{$this.lat -= [int]$r.substring(1)}
                "E"{$this.long += [int]$r.substring(1)}
                "W"{$this.long -= [int]$r.substring(1)}
                "L"{$slo = $this.long
                    $sla = $this.lat
                    switch([int]$r.substring(1)){
                    0{}
                    90{$this.lat=$slo;$this.long =-$sla}
                    180{$this.lat=-$sla;$this.long =-$slo}
                    270{$this.lat=-$slo;$this.long =$sla}
                }}
                "R"{$slo = $this.long
                    $sla = $this.lat
                    switch([int]$r.substring(1)){
                    0{}
                    90{$this.lat=-$slo;$this.long =$sla}
                    180{$this.lat=-$sla;$this.long =-$slo}
                    270{$this.lat=$slo;$this.long =-$sla}
                }}
                "F"{
                    $x = [int]$r.substring(1)
                    $posLon += $this.long * $x
                    $posLat += $this.lat * $x
                }
            }
            write-host " Kan det vara " $this.long + $this.lat " Åt " $posLon " e och " $posLat
        }
        if($posLon -lt 0){
            $posLon = -$posLon
        }
        if($posLat -lt 0){
            $posLat = -$posLat
        }
        
        write-host "Kan det vara "($posLat + $posLon)
    }

}

$ship = [Ship]::new($indata)

#$ship.part1()
$ship.part2()
Remove-Variable -name "ship"