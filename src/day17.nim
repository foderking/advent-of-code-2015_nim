import download, strutils, sequtils, sugar, strscans, algorithm, tables, strformat


proc part1(input: string): int=
  let arr = input.split('\n').map(each => each.parseInt).sorted(SortOrder.Descending)
  echo arr
  var m = 0
  #var mem = newSeq[int](151)
  var mxm = 0
  var g: seq[int]
  proc solve(i, n: int)=
    #echo n
    #echo fmt"{i} {n}"
    if n==0:
      mxm += 1
      #echo g
      return

    for ind in i..<arr.len:
      let each = arr[ind]
      if each>n: continue
      #mxm += (n div each) * solve(n mod each, tmp)
      g.add(each)
      solve(ind+1,n - each)
      discard g.pop()

    return
  
  solve(0, 150)
  return mxm

proc part2(input: string): int=
  let arr = input.split('\n').map(each => each.parseInt).sorted(SortOrder.Descending)
  echo arr
  var m = 0
  #var mem = newSeq[int](151)
  var
    mxm = 0
    g: seq[int]
    dict: Table[int, int]
    m_len = high(int)

  proc solve(i, n: int)=
    #echo n
    #echo fmt"{i} {n}"
    if n==0:
      mxm += 1
      #echo g
      
      dict[g.len] = dict.getOrDefault(g.len, 0)+1
      m_len  = min(m_len, g.len)
      return

    for ind in i..<arr.len:
      let each = arr[ind]
      if each>n: continue
      #mxm += (n div each) * solve(n mod each, tmp)
      g.add(each)
      solve(ind+1,n - each)
      discard g.pop()

    return
  
  solve(0, 150)
  return dict[m_len]


when isMainModule:
  doPart1(part1, "17")
  doPart2(part2, "17")
