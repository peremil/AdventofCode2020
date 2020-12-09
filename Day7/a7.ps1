class Bkeeper {
    $bag = @{}
    $gold = @{}
    $cnt
    Bkeeper(){
        
    }

    AddBag($in){
        #write-host $in
        $in = $in.split(" ")
        $bm =$in[0] +" "+ $in[1]
        #$this.bag.add($in[0],)
        $c = 0
        $b1 = ""
        $b2 = ""
        foreach($b in $in){
            #write-host $b1 $b2
            if($b -like "bag*"){
                #write-host $b1 $b2
                if($b1 +" "+$b2 -ne $bm  -and $b1 +" "+$b2 -ne "no other"){
                    if($this.bag.containskey($b1 +" "+$b2)){
                        $this.bag[$b1 +" "+$b2] += $bm
                        }else{
                        $this.bag[$b1 +" "+$b2] = @($bm)
                    }
                }
            }
            $b1 = $b2
            $b2 = $b
            
        }
    }

    [string]Clean($in){
       $remove = @("bags","bag",".",1,2,3,4,5,6,7,8,9,0)
       foreach($r in $remove){
            $in.replace($r, "")
       }
       return $in 
    }

    [int]CheckParent($b){
        $c = 0
        foreach($p in $this.bag[$b]){
            if($p -ne "no otherx"){
            $c ++
            write-host $p " " $c
            $this.gold[$p] ++
            $c += $this.CheckParent($p)
            }
        }
        return $c
    }

    [int]Count(){
        $c = 0
        write-host $this.bag["shiny gold"][0]
        foreach($b in $this.bag["shiny gold"]){
            $this.gold[$b] ++
            $c += $this.CheckParent($b)
        }
        write-host $this.gold.count
        write-host $this.bag.count
        #$c = 0
        #$c = $this.bag["shiny gold"].count
        #Foreach ($Key in ($this.yes.GetEnumerator() | Where-Object {$_.Value -eq $this.cnt})){$c++}
        $this.gold.GetEnumerator().name |set-content  C:\Users\per\OneDrive\script\advent2020\utpart7.txt -force

        
        return $c
    }
}



#$indata =@("BFFFBBFRRR","FFFBBBFRRR","BBFFBBFRLL")

$fil = ".\Day7\part7.txt"
$indata = get-content $fil
#$indata += ""

$count = 0
$pp = @()
$c = 0
$c2 = 0

$keeper = [Bkeeper]::new()
foreach($in in $indata){
    $keeper.AddBag($in)
    
}

$keeper.Count()
#$count = [Travel]::new($indata).Go(3,1)
$diff = get-content "C:\Users\per\OneDrive\script\advent2020\unique.txt"
compare-object -ReferenceObject $keeper.gold.GetEnumerator().name -DifferenceObject $diff |select-object 

#$count = [Travel]::new($indata).Go(1,1) * [Travel]::new($indata).Go(3,1)  * [Travel]::new($indata).Go(5,1) * [Travel]::new($indata).Go(7,1) * [Travel]::new($indata).Go(1,2)

$count
