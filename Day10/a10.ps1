Class AdaptorCount{

 [int[]]$data
 [int]$dMax
 [long]$count
 [int]$part1
 [long]$part2

    AdaptorCount($in){
        $in += 0
        $this.data = $in |sort
        #$this.data
        $this.dMax = $in.count
        $this.count=0
        $this.part1=0
    }

    Xcounter1(){
        $l = 0
        $c1 = 0
        $c3 = 0
        
        $this.data |foreach {
            if($l+1 -eq $_ ){
                $l = $_
                $c1 ++
            }elseif($l+2 -eq $_){
                $l = $_
            }elseif($l+3 -eq $_){
                $l = $_
                $c3 ++
            }else{
                #write-host "Too high! "
            }
        }
        $this.part1=$c1 * $c3
        #write-host "Del 1: "($c1 * $c3)
    }

    Xcounter2(){
        [long[]]$ca = @(1)
        $i = 0
        foreach($v in $this.data){
            $ca +=0
            $x = $i-1
            while($x -ge 0 -and $v - $this.data[$x] -le 3){
                $ca[$i] += $ca[$x]
                $x--
            }
            $i++
        }

        $ca = $ca |sort
        $this.part2 = $ca[-1]
    }
  
}

$fil = ".\Day10\ina10.txt"
#$fil = ".\Day10\test10.txt"
#$fil = ".\Day10\ltest10.txt"

[int[]]$indata = get-content $fil

$counter = [AdaptorCount]::new($indata)
$counter.Xcounter1()
write-host "Del 1 = " $counter.part1

$counter.Xcounter2()
write-host "Del 2 = " $counter.part2

