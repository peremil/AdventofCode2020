class Group {
    $yes = @{}
    $cnt
    Group(){
        $this.cnt= 0
    }

    AddQ($in){
        $this.cnt++
        $in = $in.toCharArray()
        foreach($i in $in){
            $this.yes[$i] ++
        }
    }

    [int]Count(){
        $c = 0
        Foreach ($Key in ($this.yes.GetEnumerator() | Where-Object {$_.Value -eq $this.cnt})){$c++}
        return $c

    }
}



#$indata =@("BFFFBBFRRR","FFFBBBFRRR","BBFFBBFRLL")

$fil = ".\Day6\ina6.txt"
$indata = get-content $fil
$indata += ""

$count = 0
$c = 0
foreach($in in $indata){
    if($c -eq 0){
        $group = [Group]::new()
    }
    if($in -eq ""){
        $count += $group.Count()
        $c = 0
    }else{
        $group.AddQ($in)
        $c ++
    }
    
}
$count
