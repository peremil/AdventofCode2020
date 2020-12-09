$fil = ".\Day7\ina7.txt"
$indata = get-content $fil

$bags = @{}
$uniqbags = @{}
$pattern = "^(?<bag>\w+ \w+)|(?<contain>\d \w+ \w+)"

($indata | sls -Pattern $pattern -AllMatches).matches | % {
    if ($_.groups['bag'].value) {
        $tempbag = $_.groups['bag'].value
    }
    if ($_.groups['contain'].value) {
        $s = $_.groups['contain'].value.Substring(2)
        if($bags.ContainsKey($s)){
            $bags[$s] += $tempbag
        }else{
            $bags[$s] = @($tempbag)
        }
    }
}

function Dig($bag){
    if($bags.ContainsKey($bag)){
        $bags[$bag] | foreach-object {$uniqbags[$_]++; Dig($_)}
    }
}

Dig('shiny gold')
write-host $uniqbags.count

