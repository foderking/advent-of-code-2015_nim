import download
import tables, strscans, strutils, strformat, sets

proc solve1(person: string, visits: HashSet[string])=
  echo ""


proc parse(input: string): Table[string, Table[string, int]]=
  var
    dict : Table[string, Table[string, int]]
    a, b: string
    n: int
  
  for line in input.split('\n'):
    if scanf(line, "$+ would lose $i happiness units by sitting next to $+.", a, n, b):
      if a notin dict: dict[a] = initTable[string, int]()
      dict[a][b] = -n

      #echo fmt"{a} {b} <- {n}"
    elif scanf(line, "$+ would gain $i happiness units by sitting next to $+.", a, n, b):
      if a notin dict: dict[a] = initTable[string, int]()
      dict[a][b] = n

      #echo fmt"{a} {b} -> {n}"
    else: raiseAssert("")
  return dict

proc part1(input: string)=
  let ninf =  low(int32).int
  let dict = parse(input)
  let dlen = dict.len
  var
    visits : HashSet[string]

  proc solve(person: string, l: int, g: string): int=
    if l==1: return dict[person][g] + dict[g][person]
    if person in visits: return ninf

    #echo person
    var mxm = ninf

    visits.incl(person)

    for k in keys(dict):
      if visits.contains(k): continue
      mxm = max(mxm, dict[person][k]+dict[k][person] + solve(k, l-1, g))

    visits.excl(person)
    return mxm



  for g in keys(dict):
    echo solve(g, dlen, g)
    break

proc part2(input: string)=
  let ninf =  low(int32).int
  var dict = parse(input)
  let dlen = dict.len
  var
    visits : HashSet[string]

  dict["xxx"] = initTable[string, int]()
  for k in keys(dict):
    dict[k]["xxx"] = 0
    dict["xxx"][k] = 0

  proc solve(person: string, l: int, g: string): int=
    if l==1: return dict[person][g] + dict[g][person]
    if person in visits: return ninf

    #echo person
    var mxm = ninf
    visits.incl(person)


    for k in keys(dict):
      if visits.contains(k): continue
      mxm = max(mxm, dict[person][k]+dict[k][person] + solve(k, l-1, g))

    visits.excl(person)
    return mxm



  for g in keys(dict):
    echo solve(g, dlen+1, g)
    break


when isMainModule:
  let d = download("13")
  part1(d)
  part2(d)
