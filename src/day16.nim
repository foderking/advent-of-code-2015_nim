import download, strutils, strscans, sequtils, sugar

type
  rand = tuple
    child, cat, sam, pom, ak, viz, gold, tree, car, pef, i: int

proc part1(input: string): int=
  var
    arr = newSeq[rand](501)
  for sue in input.split('\n'):
    #echo sue
    var
      r: rand
      tmp: int
      s: string
    if scanf(sue, "$*children: $i", s, tmp):
      r.child = tmp
    else:
      r.child = -1

    if scanf(sue, "$*cats: $i", s, tmp):
      r.cat = tmp
    else:
      r.cat = -1

    if scanf(sue, "$*samoyeds: $i", s, tmp):
      r.sam = tmp
    else:
      r.sam = -1

    if scanf(sue, "$*pomeranians: $i", s, tmp):
      r.pom = tmp
    else:
      r.pom = -1

    if scanf(sue, "$*akitas: $i", s, tmp):
      r.ak = tmp
    else:
      r.ak = -1

    if scanf(sue, "$*vizslas: $i", s, tmp):
      r.viz = tmp
    else:
      r.viz = -1

    if scanf(sue, "$*goldfish: $i", s, tmp):
      r.gold = tmp
    else:
      r.gold = -1

    if scanf(sue, "$*trees: $i", s, tmp):
      r.tree = tmp
    else:
      r.tree = -1
      
    if scanf(sue, "$*cars: $i", s, tmp):
      r.car = tmp
    else:
      r.car = -1
      
    if scanf(sue, "$*perfumes: $i", s, tmp):
      r.pef = tmp
    else:
      r.pef = -1

    if scanf(sue, "Sue $i", tmp):
      #echo r
      r.i = tmp
      arr[tmp] = r
    else: raiseAssert("")

  let aaa= arr
    .filter(each => each.child==3 or each.child==(-1))
    .filter(each => each.cat==7 or each.cat==(-1))
    .filter(each => each.sam==2 or each.sam==(-1))
    .filter(each => each.pom==3 or each.pom==(-1))
    .filter(each => each.ak==0 or each.ak==(-1))
    .filter(each => each.viz==0 or each.viz==(-1))
    .filter(each => each.gold==5 or each.gold==(-1))
    .filter(each => each.tree==3 or each.tree==(-1))
    .filter(each => each.car==2 or each.car==(-1))
    .filter(each => each.pef==1 or each.pef==(-1))
    #[
  echo 
    ]#
  return aaa[0].i

proc part2(input: string): string=
  var
    arr = newSeq[rand](501)
  for sue in input.split('\n'):
    #echo sue
    var
      r: rand
      tmp: int
      s: string
    if scanf(sue, "$*children: $i", s, tmp):
      r.child = tmp
    else:
      r.child = -1

    if scanf(sue, "$*cats: $i", s, tmp):
      r.cat = tmp
    else:
      r.cat = -1

    if scanf(sue, "$*samoyeds: $i", s, tmp):
      r.sam = tmp
    else:
      r.sam = -1

    if scanf(sue, "$*pomeranians: $i", s, tmp):
      r.pom = tmp
    else:
      r.pom = -1

    if scanf(sue, "$*akitas: $i", s, tmp):
      r.ak = tmp
    else:
      r.ak = -1

    if scanf(sue, "$*vizslas: $i", s, tmp):
      r.viz = tmp
    else:
      r.viz = -1

    if scanf(sue, "$*goldfish: $i", s, tmp):
      r.gold = tmp
    else:
      r.gold = -1

    if scanf(sue, "$*trees: $i", s, tmp):
      r.tree = tmp
    else:
      r.tree = -1
      
    if scanf(sue, "$*cars: $i", s, tmp):
      r.car = tmp
    else:
      r.car = -1
      
    if scanf(sue, "$*perfumes: $i", s, tmp):
      r.pef = tmp
    else:
      r.pef = -1

    if scanf(sue, "Sue $i", tmp):
      #echo r
      r.i = tmp
      arr[tmp] = r
    else: raiseAssert("")

  let aaa= arr
    .filter(each => each.child==3 or each.child==(-1))
    .filter(each => each.cat>7 or each.cat==(-1))
    .filter(each => each.sam==2 or each.sam==(-1))
    .filter(each => each.pom<3 or each.pom==(-1))
    .filter(each => each.ak==0 or each.ak==(-1))
    .filter(each => each.viz==0 or each.viz==(-1))
    .filter(each => each.gold<5 or each.gold==(-1))
    .filter(each => each.tree>3 or each.tree==(-1))
    .filter(each => each.car==2 or each.car==(-1))
    .filter(each => each.pef==1 or each.pef==(-1))
    #[
    ]#
  return $aaa[0].i

when isMainModule:
  doPart1(part1, "16")
  doPart2(part2, "16")
