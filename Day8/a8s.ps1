
class Operator{
    
    #$data = @()
    
    $cmd =@()
    $val = @()
    
    $accu = 0

    Operator($in){
        #$this.data = $in
        $in |%{$d = $_.split(" ");$this.cmd+= $d[0];$this.val+= $d[1]}
    }

    [int]Run1(){
        $pos = 0
        $acc = 0
        $seq = @()
        
        while($pos -lt $this.cmd.count){
            #write-debug $this.cmd[$pos]
            switch($this.cmd[$pos]){
                "acc"{$acc += $this.val[$pos];$pos++}
                "jmp"{$pos += $this.val[$pos]}
                "nop"{$pos++}
            }
            
            if($seq.Contains($pos)){
                return $acc
            }else{
                $seq += $pos
            }
            # -or $pos -gt $this.data.count
        }

        #write-host "Ending Acc: "$acc " Pos "$pos
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

        while($pos -lt $this.cmd.count){
            $c = $this.cmd[$pos]
            #$v = $this.val[$pos]
            #write-host "Command: " $c
            #write-debug $c

            if(!$test -and $c -eq "jmp" -and !$tested.Contains($pos)){$c = "nop"; $tested += $pos;$test=$true}
            elseif(!$test -and $c -eq "nop" -and !$tested.Contains($pos)){$c = "jmp"; $tested += $pos;$test=$true}
                         
            switch($c){
                "acc"{$acc += $this.val[$pos];$pos++}
                "jmp"{$pos += $this.val[$pos]}
                "nop"{$pos++}
            }
            
            if($seq.Contains($pos)){
                #write-host "restart last: " $pos " varv: " $loop
                #write-host "Testad " $tested[-1]
                $test = $false
                $seq = @()
                $pos = 0
                $acc = 0
                #Restart  -or $pos -gt $this.data.count
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
