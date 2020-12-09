
class Plane {

    $seats = @()
    $seats2 = @()
    plane(){
        
        for($i=0;$i-lt 128;$i++){
            #$this.seats[$i] = @()
            for($x=0;$x -lt 7; $x++){
                $this.seats2 += $i * 8 +$x
            }
        }
        
    }

    board($in){
        $c =0
        $pr = 0
        $pmax = 127
        $pmin = 0

        $pc = 0
        $pcmin = 0
        $pcmax = 7
        $in = $in.toCharArray()
        #write-host $in
        foreach($i in $in){
           #write-host "min " $pmin " max " $pmax " in " $i
           if($c -lt 6 -and $i -eq "F"){
                $pmax -= [math]::floor(($pmax +1 -$pmin)/2)
                #$pmax -= ($pmax -1 - $pmin)/2

           }elseif($c -eq 6 -and $i -eq "F"){
                $pr = $pmin
           }elseif($c -lt 6 -and $i -eq "B"){
                $pmin += [math]::Ceiling(($pmax +1 - $pmin)/2)
           }elseif($c -eq 6 -and $i -eq "B"){
                $pr = $pmax
           }
           elseif($c -lt 9 -and $i -eq "L"){
                $pcmax -= [math]::floor(($pcmax +1 - $pcmin)/2)
           }elseif($c -eq 9 -and $i -eq "L"){
               $pc = $pcmin
           }elseif($c -lt 9 -and $i -eq "R"){
                $pcmin += [math]::Ceiling(($pcmax +1- $pcmin)/2)
           }elseif($c -eq 9 -and $i -eq "R"){
                $pc = $pcmax
           }
           $c++
        }
        
        #write-host "Rad "$pr " col " $pc

        $this.seats += $pr *8 + $pc

        #$this.seats[$pr][$pc] = 1
    }

    [int]GetMax(){
        write-host ($this.seats | Sort-Object)
        write-host "å 2 "
        #write-host ($this.seats2 | Sort-Object)

        $r = $this.seats | Sort-Object -Descending | select -First 1
        write-host $r
        return $r
    }

    [int]GetFree(){
        $l = 0
        $f = 0
        foreach($s in ($this.seats | Sort-Object)){
            if($s -ne $l +1){
                write-host "Possible " $s
                $f = $s
            }
            $l = $s
        }

        return $f
        
    }

}


class Boarding {

    $row
    $col
    
    $id 

    Boarding($in){
                
    }
}


#$indata =@("BFFFBBFRRR","FFFBBBFRRR","BBFFBBFRLL")

$fil = ".\Day5\ina5.txt"
$indata = get-content $fil
#$indata += ""

#$count = 0
#$pp = @()
$c = 0
#$c2 = 0
$plane = [Plane]::new()
foreach($in in $indata){
    
    $plane.board($in)
    
}

write-host $plane.GetMax()
write-host $plane.GetFree()
#$count = [Travel]::new($indata).Go(3,1)

#$count = [Travel]::new($indata).Go(1,1) * [Travel]::new($indata).Go(3,1)  * [Travel]::new($indata).Go(5,1) * [Travel]::new($indata).Go(7,1) * [Travel]::new($indata).Go(1,2)

#$count
