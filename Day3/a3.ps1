
class Travel {
   $slope
   [int]$x
   [int]$y
   $count
   
    Travel ($in){
        $this.slope = @{}
        $i = 0
        foreach ($d in $in){
            $d.trim()
            $this.slope[$i] = @($d.ToCharArray())
            $i++
        }
    }
    
    [int]Go ($x,$y){
        $this.x = $x
        $this.y = $y
        $c = 0
        $p = $this.x
        $pmax = $this.slope[0].length
        for($i=$this.y;$i -lt $this.slope.count;$i +=$this.y){
            if($this.slope[$i][$p] -eq "#"){
                $c++
            }
            $p += $this.x
            if($p -ge $pmax){
                $p = $p - $pmax
            }   
        }

        return $c
    }

}

$fil = ".\Day3\ina3.txt"
$indata = get-content $fil
$count = 0

#$count = [Travel]::new($indata).Go(3,1)

$count = [Travel]::new($indata).Go(1,1) * [Travel]::new($indata).Go(3,1)  * [Travel]::new($indata).Go(5,1) * [Travel]::new($indata).Go(7,1) * [Travel]::new($indata).Go(1,2)

$count
