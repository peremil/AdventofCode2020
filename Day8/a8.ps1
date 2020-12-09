
class Operator{
    
    $data = @()
    #$seq = @()
    $accu = 0

    Operator($in){
        $this.data = $in
    }

    [int]Run1(){
        $pos = 0
        $acc = 0
        $seq = @()
        
        while($pos -lt $this.data.count){
            $d = $this.data[$pos].split(" ")
                         
            switch($d[0]){
                "acc"{$acc += $d[1];$pos++}
                "jmp"{$pos += $d[1]}
                "nop"{$pos++}
            }
            
            if($seq.Contains($pos) -or $pos -gt $this.data.count){
                return $acc
            }else{
                $seq += $pos
            }

        }

        write-host "Ending Acc: "$acc " Pos "$pos
        return 0
    }

    [int]Run2(){
        $pos = 0
        $acc = 0
        $seq = @()
        $tested = @()
        $last = 0
        $test = $false
        $loop = 0

        while($pos -lt $this.data.count){
            $d = $this.data[$pos].split(" ")
            #if($pos -eq $tested[-1] -and $d[0] -eq "jmp"){$d[0] = "nop"}
            #elseif($pos -eq $tested[-1] -and $d[0] -eq "nop"){$d[0] = "jmp"}
            
            if(!$test -and $d[0] -eq "jmp" -and !$tested.Contains($pos)){$d[0] = "nop"; $tested += $pos;$test=$true}
            elseif(!$test -and $d[0] -eq "nop" -and !$tested.Contains($pos)){$d[0] = "jmp"; $tested += $pos;$test=$true}
                         
            switch($d[0]){
                "acc"{$acc += $d[1];$pos++}
                "jmp"{$pos += $d[1]}
                "nop"{$pos++}
            }
            
            if($seq.Contains($pos) -or $pos -gt $this.data.count){
                #write-host "restart last: " $pos " varv: " $loop
                #write-host "Testad " $tested[-1]
                $test = $false
                $seq = @()
                $pos = 0
                $acc = 0
                #Restart
                $loop ++
                #return $acc
            }else{
                $seq += $pos
            }

        }

        write-host "Ending Acc: "$acc " Pos "$pos
        return $acc
    }



}



$fil = ".\Day8\ina8.txt"
$indata = get-content $fil
$c = 0
#$indata |%{$c++}




$Operator = [Operator]::new($indata)
Measure-Command {
$Operator.Run1() 
}

Measure-Command {
$c =$Operator.Run2()
}

write-host $c
#$indata  | foreach {$Operator.AddData($_)}

