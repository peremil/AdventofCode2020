
class Passport {

    $pass= @{}
    $count
    $id 
   
    Passport ($id){
        $this.id = $id
    }

    Input([string]$in){
        #write-host $this.pass.GetType()
        $data = $in.split(" ")

        foreach($d in $data){
            $kv = $d.split(":")
            $this.pass.add($kv[0] , $kv[1])
        }
    }
    
    

    [int]Valid(){
        $v = 0
        if($this.pass.ContainsKey("byr") -and $this.pass["byr"] -ge 1920 -and $this.pass["byr"] -le 2002){
            $v++
        }else{
            #write-host "Träff"
        }
    
        if($v -eq 1 -and $this.pass.ContainsKey("iyr") -and $this.pass["iyr"] -ge 2010 -and $this.pass["iyr"] -le 2020){$v++} 
    
        if($v -eq 2 -and $this.pass.ContainsKey("eyr") -and $this.pass["eyr"] -ge 2020 -and $this.pass["eyr"] -le 2030){$v++}else{
            #write-host $this.pass["eyr"]
        }
    
        if($v -eq 3 -and $this.pass.ContainsKey("hgt")){
            $dat = $this.pass["hgt"]
            $t = $dat.Substring($dat.Length-2)
            $h = $dat.Substring(0,$dat.Length-2)

            if($t -eq 'in' -and $h -ge 59 -and $h -le 76){
                #inch
                $v++ 
            
            }elseif($t -eq 'cm' -and $h -ge 150 -and $h -le 193){
                #cm
                $v++
            }

            
        }
        
        if($v -eq 4 -and $this.pass.ContainsKey("hcl")  -and $this.pass["hcl"] -match '#[a-f0-9]{6}') {
            #write-host $this.pass["hcl"] 
            $v++
        }
        $ecl = "amb|blu|brn|gry|grn|hzl|oth"
        if($v -eq 5 -and $this.pass.ContainsKey("ecl") -and $this.pass["ecl"] -match $ecl){$v++} #     
    
        if($v -eq 6 -and $this.pass.ContainsKey("pid") -and $this.pass["pid"].length -eq 9 -and $this.pass["pid"] -match '[0-9]{9}'){
            write-host $this.pass["pid"] 
            $v++
        }
    
        if($v -eq 7){
            #write-host "ok " $this.id
            return 1
        }else{
            #write-host "miss " $this.id
            return 0
        }
        
    }    


}

$fil = ".\Day4\ina4.txt"
$indata = get-content $fil
$indata += ""

$count = 0
$pp = @()
$c = 0
$c2 = 0
foreach($in in $indata){
    if($in -eq ""){
        #write-host "Is null " $in
        #$pass.GetType()
        $count += $pass.Valid()
        $c++
        $c2 = 0
    }else{
        
        if($c2 -eq 0){
            #write-host $c
            $pass = [Passport]::new($c)
            $pass.Input($in)
            $c2++
        }else{
            #write-host $in
            $pass.Input($in)
            #$pass.GetType()
        } 
        #write-host "Es data " $in
        #$pp[$c] = [Passport]::new().Input($in)
    }
    
}

$count
