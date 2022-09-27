$fil = ".\Day14\ina14.txt"
#$fil = ".\Day14\test14.txt"
#$fil = ".\Day14\test14-2.txt"

$indata = get-content $fil

class Docking {
    $mem = @{}
    $mem2 = @{}
    $mask = ""

    Docking(){
 
    }

    Part1($in){
        foreach($r in $in){
            #write-host "Indata  "$r
            $data = $r.split(" = ")
            if($data[0].substring(0,3) -eq "mas"){
                #write-host "mask "$data[1]
                $this.mask = $data[1]
            }elseif($data[0].substring(0,3) -eq "mem"){
                #rite-host "mem " ($data[0].substring(4,$data[0].length -5))
                $m = $data[0].substring(4,$data[0].length -5)
                $v = [Convert]::ToString($data[1],2)
                $uv = ""
                #write-host "mem v " $v
                $x = $this.mask.length - ($v.length)
                for($i = 0;$i -lt $this.mask.length;$i++){
                    #write-host "Test $i och $x val " $v[$i-$x]
                    if($this.mask[$i] -ne "X"){
                        $uv+=$this.mask[$i]
                    }elseif($i -ge $x -and $v[$i-$x] -eq "1"){
                        #write-host "write $i val " $v[$i-$x]
                        $uv+= 1
                    }else{
                        $uv+= 0
                    }
                }
                #write-host "write 1:" $v
                #write-host "write 1:" $this.mask
                #write-host "write 1:" $uv
                #write-host "write 2:" ([Convert]::ToInt64($uv,2))
                #$this.mem.add($m,[Convert]::ToInt32($uv,2))
                if($this.mem[$m]){
                    $this.mem[$m] = [Convert]::ToInt64($uv,2)
                }else{
                    $this.mem.add($m,[Convert]::ToInt64($uv,2))
                }

            }
        }
        $sum = 0
        foreach($k in $this.mem.keys){
            $sum += $this.mem[$k]
        }
        write-host "Summan "$sum

    }

    Part2($in){
        foreach($r in $in){
            #write-host "Indata  "$r
            $data = $r.split(" = ")
            if($data[0].substring(0,3) -eq "mas"){
                #write-host "mask "$data[1]
                $this.mask = $data[1]
            }elseif($data[0].substring(0,3) -eq "mem"){
                #rite-host "mem " ($data[0].substring(4,$data[0].length -5))
                $m = $data[0].substring(4,$data[0].length -5)
                $val = $data[1]
                $v = [Convert]::ToString($m,2)
                $uv = ""
                #write-host "mem v " $v
                $x = $this.mask.length - ($v.length)
                for($i = 0;$i -lt $this.mask.length;$i++){
                    #write-host "Test $i och $x val " $v[$i-$x]
                    if($this.mask[$i] -ne "0"){
                        $uv+=$this.mask[$i]
                    }elseif($i -ge $x -and $v[$i-$x] -eq "1"){
                        #write-host "write $i val " $v[$i-$x]
                        $uv+= 1
                    }else{
                        $uv+= 0
                    }
                }
                #write-host "write 1:" $v
                #write-host "write 1:" $this.mask
                #write-host "write 1:" $uv
                #write-host "write 2:" ([Convert]::ToInt64($uv,2))
                #$this.mem.add($m,[Convert]::ToInt32($uv,2))
                [string[]]$nu = @()
                $nu += $null
                foreach($c in $uv.ToCharArray()){
                #$uv.ToCharArray()| %{
                    #write-host "Ånu: " $c
                    if($c -eq "X"){
                        $i = 0
                        [string[]]$tmp = @()
                        while($i -lt $nu.count){
                            $tmp +=  $nu[$i]
                            $nu[$i] += 0
                            $tmp[$i] += 1
                            $i++
                        }
                        $nu += $tmp

                    }else{
                        $i = 0
                        while($i -lt $nu.count){
                            $nu[$i] += $c
                            $i++
                        }
                    }

                }
                
                $nu |%{
                    #write-host "Skriver "$_
                    if($this.mem2[$_]){
                        $this.mem2[$_] = $val
                    }else{
                        $this.mem2.add($_, $val)
                    }
                    #$this.mem2 += [Convert]::ToInt64($_,2)
                }
                #$this.mem2 += [Convert]::ToInt64($uv,2)
                

            }
        }
        $sum = 0
        foreach($k in $this.mem2.keys){
            $sum += $this.mem2[$k]
        }

        write-host "Summan "$sum

    }

}

$dock = [Docking]::new()

$dock.Part2($indata)

Remove-Variable -name "dock"



