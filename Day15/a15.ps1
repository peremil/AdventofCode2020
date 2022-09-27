$fil = ".\Day15\ina15.txt"

class EGame{


    Part1(){

        $start = @(5,1,9,18,13,8,0)
        #$start = @(0,3,6)
        $used = @{}
        
        $go = $true
        [long]$t = 0
        #$n = $start[$t-1]
        [int]$n = $null
        $start|%{
            if($t -gt 0){
                #write-host "Skriver $n vid $t"
                $used.add($n,$t)
            }
            $n = $_
            $t++
        }
        #write-host "Test " $used[3]
        #write-host "Last $n vid $t"
        while($t -lt 30000000){
            #write-host "Checking $t and "$n
            if($used.containskey($n)){
                $c = $used[$n]
                $used[$n] = $t
                #write-host "Counting $t and "$c
                $n = $t-$c
            }else{
                $used.add($n,$t)
                $n = 0
            }
            #write-host "Think we talk t "($t+1)" and $n"
            $t ++
        }
        write-host "Think we talk about $n"

    }

}

$game = [EGame]::new()
$game.Part1()
