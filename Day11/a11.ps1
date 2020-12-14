$fil = ".\Day11\ina11.txt"
#$fil = ".\Day11\test11.txt"

$indata = get-content $fil

class SeatCode{

    $data = @{}
    #$xdata = @()
    $all = @()
    $seats = @()
    $seatNbr = @{}
    $seatStat = @{}
    $seatCnt
    $seatCnt2 = @{}  
    $changes = 0
    $xMax
    $yMax
    $occupied

    SeatCode($in){
        $y = 0
        foreach($r in $in){
            $this.data.add($y,$r.toCharArray())
            $y++
        }
        
        $this.yMax = $y
        $this.xMax = $this.data[0].count
        $this.seatCnt = New-Object 'int[,]' ($this.yMax),($this.xMax)
        
    }
    
    SetNbr2(){
        #Make list of shairs in sight of eachother
        $l = ""
        for($y = 0;$y -lt $this.yMax;$y++){
            for($x = 0;$x -lt $this.xMax;$x++){
                $this.seatNbr.add("$y,$x",@())
                $this.seatCnt2.add("$y,$x",0)
            }
        }

        for($y = 0;$y -lt $this.yMax;$y++){
            $l = ""
            for($x = 0;$x -lt $this.xMax;$x++){
                if($this.data[$y][$x] -ne "."){
                    if($l -ne ""){
                        $this.seatNbr[$l]+="$y,$x"
                        $this.seatNbr["$y,$x"]+=$l
                    }
                    $v = $y+1
                    while($v -lt $this.yMax){
                        if($this.data[$v][$x] -ne "."){
                            $this.seatNbr["$v,$x"]+="$y,$x"
                            $this.seatNbr["$y,$x"]+="$v,$x"
                            $v = $this.yMax +1
                        }
                        $v++
                    }
                    $v = $y+1
                    $h = $x+1
                    while($v -lt $this.yMax -and $h -lt $this.xMax){
                        if($this.data[$v][$h] -ne "."){
                            $this.seatNbr["$v,$h"]+="$y,$x"
                            $this.seatNbr["$y,$x"]+="$v,$h"
                            $v = $this.yMax +1
                        }
                        $v++
                        $h++
                    }
                    $v = $y+1
                    $h = $x-1
                    while($v -lt $this.yMax -and $h -ge 0){
                        if($this.data[$v][$h] -ne "."){
                            $this.seatNbr["$v,$h"]+="$y,$x"
                            $this.seatNbr["$y,$x"]+="$v,$h"
                            $v = $this.yMax +1
                        }
                        $v++
                        $h--
                    }

                    $l="$y,$x"
                }
            }
        }
    }


    TellNbr()
    {
        #count chars and add to its neighbours
        for($y = 0;$y -lt $this.yMax;$y++){
            for($x = 0;$x -lt $this.xMax;$x++){
                if($this.data[$y][$x] -eq "#"){
                    $yf = $y-1
                    $yl = $y+1
                    $xf = $x-1
                    $xl = $x+1
                    if($y -eq 0){
                        $yf = 0
                        $yl = $y+1
                    }elseif($y -ge $this.yMax-1){
                        $yf = $y-1
                        $yl = $this.yMax-1 
                    }
                    if($x -eq 0){
                        $xf = 0
                        $xl = $x+1
                    }elseif($x -ge $this.xMax-1){
                        $xf = $x-1
                        $xl = $this.xMax-1
                    }

                    for($a = $yf;$a -le $yl; $a++){
                        for($b =$xf; $b -le $xl;$b++){
                            $this.seatCnt[$a,$b]++
                        }
                    }
                }
            }
        }
    }

    TellNbr2()
    {
        #count chars and add to its neighbours in neighbourlist
        for($y = 0;$y -lt $this.yMax;$y++){
            for($x = 0;$x -lt $this.xMax;$x++){
                if($this.data[$y][$x] -eq "#"){
                    $this.seatNbr["$y,$x"] |%{
                        $this.seatCnt2[$_]++
                    }
                }
            }
        }

    }

    [int]RunP1(){
        #Runner for part 1
        do{
            $this.DecodeP1()
        }while($this.changes -gt 0)
        $this.Matrix()
        write-host "Occupied " $this.occupied
        return $this.occupied
    }

    [int]RunP2(){
        #Runner for part 2
        $this.SetNbr2()
        do{
            $this.DecodeP2()
        }while($this.changes -gt 0)
        $this.Matrix()
        write-host "occupied = " $this.occupied
        return $this.occupied
    }

    Matrix(){
        #Print the maitris of shairs

        $s = 0
        foreach($r in $this.data.keys){
            [string]$xr =""
            $this.data[$r] |%{$xr +=$_;if($_-eq "#"){ $s++}}
            write-host $xr
        }
        $this.occupied = $s
    }

    DecodeP1(){
        #Find and update status of shairs for part 1
        $this.TellNbr()

        $cn = 0
        for($y = 0;$y -lt $this.yMax;$y++){
            for($x = 0;$x -lt $this.xMax;$x++){
                #write-host "seat y $y x $x  nbrc " $this.seatCnt[$y,$x]
                switch($this.data[$y][$x]){
                    "#"{if($this.seatCnt[$y,$x] -gt 4){$this.data[$y][$x] = "L";$cn++}}
                    "L"{if($this.seatCnt[$y,$x] -lt 1){$this.data[$y][$x] = "#";$cn++}}
                    "."{}
                }
                $this.seatCnt[$y,$x] = 0
            }
        }
        $this.changes = $cn
    }

    DecodeP2(){
        #Find and update status of shairs for part 2
        $this.TellNbr2()

        $cn = 0
        for($y = 0;$y -lt $this.yMax;$y++){
            for($x = 0;$x -lt $this.xMax;$x++){
                switch($this.data[$y][$x]){
                    "#"{if($this.seatCnt2["$y,$x"] -gt 4){$this.data[$y][$x] = "L";$cn++}}
                    "L"{if($this.seatCnt2["$y,$x"] -lt 1){$this.data[$y][$x] = "#";$cn++}}
                    "."{}
                }
                $this.seatCnt2["$y,$x"] = 0
            }
        }
        $this.changes = $cn
    }
 
}

#Execute part1 and part 2

$coder = [SeatCode]::new($indata)
Measure-Command{
$coder.RunP1()
}
$coder2 = [SeatCode]::new($indata)
Measure-Command{
$coder2.RunP2()
}
Remove-Variable -name "coder"
Remove-Variable -name "coder2"