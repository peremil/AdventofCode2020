class XMASDecoder{
    [long[]]$data = @()
    $dMax 
    $xNo
    $xWeakness

    XMASDecoder($in){
        $this.data = $in
        $this.dMax = $this.data.count
    }
        
    [int]Decode(){
        $p = 25
        while($p -lt $this.dMax){
            
            if(!$this.CheckNo($p)){
                $this.xNo = $this.data[$p]
                write-host "Found xNo " $this.xNo
                return $this.data[$p]
            }
            $p++
        }
        return 0
    }

     [Bool]CheckNo($n){
        $v = $this.data[$n]
        $prev = $this.data[($n-25)..($n-1)]

        foreach($s in $prev){
            if($prev.contains($v - $s)){
                #write-host "Found match " $v
                return $true
            } 
        }
        return $false
    }

    [int]GetWeakness(){
        $v = $this.xNo
        $vl = 0
        $vh = 0
        $p = 0

        while($p -lt $this.dMax){
            
            $i= $p+1
            [int]$sum = $this.data[$p]
            [int]$vl=$this.data[$p]
            [int]$vh=$this.data[$p]

            while($sum -le $v){
                #write-host "Summa " $sum "Low " $vl " Hög " $vh
                $sum += $this.data[$i]
                if($this.data[$i] -lt $vl){$vl =$this.data[$i]}
                if($this.data[$i] -gt $vh){$vh =$this.data[$i]}

                if($sum -eq $v){
                    $this.xWeakness = $vl + $vh
                    return $vl + $vh
                }
                $i++
            }

            $p++
        }
        return 0
    }
}

$fil = ".\Day9\ina9.txt"

[long[]]$indata = get-content $fil
$c = 0

$XMASDecoder = [XMASDecoder]::new($indata)

Measure-Command {
    $c = $XMASDecoder.Decode() 
}
write-host $c
Measure-Command {
    $c = $XMASDecoder.GetWeakness() 
}

write-host $c
