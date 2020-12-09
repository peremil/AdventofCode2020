
class validatorB {


}

class Password {
   $pass
   $m
   $p1
   $p2
   $count
   
    Password ([string]$in){
        $data = $in.split(" ")
        $par = $data[0].split("-")
        $this.p1 = $par[0]
        $this.p2 = $par[1]
        $this.m = $data[1].substring(0,1)
        $this.pass = $data[2]
    }
    
    [string]validate() {
        if($this.pass[$this.p1-1] -eq $this.m -xor $this.pass[$this.p2-1] -eq $this.m){
        #write-host "Rule hit! "  $data[2]
        return 1
        }
        return 0
    }
}

function validatepassA([string]$in){
    $data = $in.split(" ")
    $par = $data[0].split("-")
    $l = $data[1].substring(0,1)
    $m = ([regex]::Matches($data[2],$l)).count
    if($m -ge $par[0] -and $m -le $par[1]){
        #write-host "Rule hit! "  $data[2]
        return 1
    }
    return 0 
    #write-host $m

}

function validatepassB([string]$in){
    $data = $in.split(" ")
    $par = $data[0].split("-")
    $l = $data[1].substring(0,1)
    $m = ([regex]::Matches($data[2],$l)).count
    
    if($data[2][$par[0]-1] -eq $l -xor $data[2][$par[1]-1] -eq $l){
        #write-host "Rule hit! "  $data[2]
        return 1
    }
    return 0 
    #write-host $m

}

#$indata = @("1-3 a: abcde","1-3 b: cdefg","2-9 c: ccccccccc")

$fil = ".\Day2\ina2.txt"
$indata = get-content $fil
$count = 0
foreach ($d in $indata){
    #$count += validatepassB($d)
    $count += [Password]::new($d).validate()
}

$count
