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
        $this.bag.add($bm,@{})
        $c = 0
        $no = ""
        $b1 = ""
        $b2 = ""
        foreach($b in $in){
            #write-host $b1 $b2
            if($b -like "bag*"){
                #write-host $b1 $b2
                if($b1 +" "+$b2 -ne $bm -and $b1 +" "+$b2 -ne "no other"){
                    $this.bag[$bm].add($b1 +" "+$b2, $no)
                }
            }
            $no = $b1
            $b1 = $b2
            $b2 = $b
            
        }
    }


    [int]CheckParent($b){
        [int]$c = 0
        foreach($p in $this.bag[$b].keys){

            write-host $this.bag[$b][$p] $p
            
            $c += $this.bag[$b][$p]
            $i = $this.bag[$b][$p]
            
            $r = $this.CheckParent($p)
            $c += $r * $i
            write-host "c " $c " r " $r " i " $i 
        }
        write-host $c
        return $c
    }

    [int]Count(){
        $c = 0
        write-host $this.bag["shiny gold"]
        foreach($b in $this.bag["shiny gold"].keys){
            write-host $this.bag["shiny gold"][$b]
            $i = $this.bag["shiny gold"][$b]
            #$this.gold[$b] ++
            $c += $i
            $r = $this.CheckParent($b)
            $c += $r* $i
            write-host $c
        }
        write-host $this.gold.count
        return $c

    }


}



#$indata =@("BFFFBBFRRR","FFFBBBFRRR","BBFFBBFRLL")

$fil = ".\Day7\ina7.txt"
$indata = get-content $fil

$c = 0

$keeper = [Bkeeper]::new()
foreach($in in $indata){
    $keeper.AddBag($in)
}
$keeper.Count()


