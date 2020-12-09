
function checkArr($arr){
    foreach($a in $arr){
        $a = [int]$a
        foreach($b in $arr){
            $b = [int]$b
            foreach($c in $arr){
                $c = [int]$c
                if($a+$b+$c -eq 2020){
                    $r = $a*$b*$c

                    return $r
                }
            }
            #write-host $b
        }
    }
    return 0
}


#$arrNum = @(1721,979,366,299,675,1456)
$fil = ".\Day1\ina1.txt"
$arrNum = get-content $fil

$res = checkArr($arrNum)

write-host $res


#1721,979,366,299,675,1456