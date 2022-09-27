$fil = ".\Day13\ina13.txt"
#$fil = ".\Day12\test12.txt"

$indata = get-content $fil


class Buss{

    $ets
    $bus = @()

    Buss($in){
        $rn = 0
        foreach($r in $in){
            if($rn -eq 0){
                $this.ets = $r
            }else{
                $r.split(",")|%{
                    $this.bus += $_
                }
            }
            $rn++
        }
    }

    Part1(){
        $buc =@{}
        $l = $this.ets
        $lb = 0
        $this.bus | %{
            if($_ -ne "x"){
                $buc.add($_,[int]$_ - $this.ets % [int]$_)

                if($buc[$_] -lt $l){$l = $buc[$_];$lb = $_}
            }
        }
        $tot = $l * $lb
        write-host "Bussen är $l och $lb tot $tot :" $buc[$lb] 
    }

    Part2(){
        #$tc = 1
        #$l = 0
        #$lb = 0
        $loop = 1
        $n =0
        $i = 0
        [long]$c =0
        $this.bus |%{
            if($_ -eq "x"){}
            else{
                if($tl -gt $_){
                    write-host "Jag är större" 
                }
                if($c -gt 0){
                    #write-host "Start check $_ mot ($i + $n) blir men " (($i + $n) % [int]$_)
                    while(($i + $n) % [int]$_ -ne 0){
                        #write-host "check $_ mot ($i + $n) blir  men " (($i + $n) % [int]$_)
                        $i+=$loop
                    }
                    #$tc += $i * $_
                }
                $loop *= $_
                
            }
            $n++
            $c++
        }
        write-host "Slutet "$i

    }
}



$buss = [buss]::new($indata)

$buss.part2()
