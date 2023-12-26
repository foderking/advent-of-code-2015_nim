import download, strutils, sequtils, sugar, strscans


proc serializeWeights(input: string): seq[int]=
  return input.split("\n").map(each => parseInt(each))

proc sum(x: seq[int]): int= 
  var tmp = 0
  for y in x:
    tmp += y
  return tmp

proc prod(x: seq[int]): uint64= 
  var tmp = 1u64
  for y in x:
    
    tmp = tmp * y.uint64
  return tmp

proc getAllValidArrangementGroups(
  index: int, n: int, weights: seq[int],
  acc: array[3, var seq[int]]): uint64 =
  if index < n:
    let tmp = weights[index]
    var quant = uint64.high()
    # first  group
    acc[0].add(tmp)
    quant = min(quant, getAllValidArrangementGroups(index+1,n,weights,acc))
    discard acc[0].pop()
    #echo quant
    # second group
    acc[1].add(tmp)
    quant = min(quant, getAllValidArrangementGroups(index+1,n,weights,acc))
    discard acc[1].pop()
    #echo quant
    # third  group
    acc[2].add(tmp)
    quant = min(quant, getAllValidArrangementGroups(index+1,n,weights,acc))
    discard acc[2].pop()
    #echo quant

    return quant
  else:
    if acc[0].sum() == acc[1].sum() and acc[1].sum() == acc[2].sum():
      echo acc[0],",",acc[1],",",acc[2]
      #echo acc[0].prod()
      return acc[0].prod()
    else:
      return uint64.high()

proc part1(input: string): uint64=
  let weights =  serializeWeights(input)
  var group1: seq[int] = newSeq[int]()
  var group2: seq[int] = newSeq[int]()
  var group3: seq[int] = newSeq[int]()

  let quantomNo = getAllValidArrangementGroups(
    0,weights.len(),weights,[group1,group2,group3]
  )
  return quantomNo

proc part2(input: string): string=
  return ""

when isMainModule:
  partOne(part1, "24")
  partTwo(part2, "24")
