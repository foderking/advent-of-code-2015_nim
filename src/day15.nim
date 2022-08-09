import tables, download, strutils, strscans, strformat, sequtils, sugar

type
  rand = tuple
    c, d, f, t, cal: int
  dict = Table[string, rand]

proc `+`(a, b: rand): rand=
  return (c: a.c+b.c, d: a.d+b.d, f: a.f+b.f, t: a.t+b.t, cal: a.cal+b.cal)

proc `*`(a: rand, b: int): rand=
  return (c: a.c*b, d: a.d*b, f: a.f*b, t: a.t*b, cal: a.cal*b)

proc `-`(a, b: rand): rand=
  return (c: a.c-b.c, d: a.d-b.d, f: a.f-b.f, t: a.t-b.t, cal: a.cal-b.cal)

proc absol(tmp: rand): int=
  return max(0, tmp.c) * max(0, tmp.d) * max(0, tmp.f) * max(0, tmp.t)# * tmp.cal

proc parse(input: string): dict=
  var
    name: string
    capac: int
    durab: int
    flav: int
    text: int
    cal: int
    g: dict

  for line in input.split('\n'):
    if scanf(line, "$+: capacity $i, durability $i, flavor $i, texture $i, calories $i",
             name, capac, durab, flav, text, cal):
      g[name] = (c: capac, d: durab, f: flav, t: text, cal: cal)
    else:
      raiseAssert("")

  return g


proc part1(input: string): int=
  var
    mxm = 0
    m_d: rand
  let
    dd = parse(input)
    k = dd.keys().toSeq
    n = k.len

  proc solve(i, rem: int, tmp: var seq[int])=
    if i==1:
      var t = (c: 0, d: 0, f: 0, t: 0, cal: 0)
      let tp = (tmp & rem)
      #echo tp
      for j in 0..<n:
      #  echo dd[k[j]]*tp[j]
        t = t + dd[k[j]]*tp[j]
      #echo t
      #echo absol(t)
      if absol(t)>mxm:
        mxm = absol(t)
        m_d = t
      #[
          ]#
    else:
      for x in 1..(rem-n+1):
        tmp.add(x)
        solve(i-1, rem-x, tmp)
        discard tmp.pop()


  var tt: seq[int] = @[]
  solve(n, 100, tt)
  echo mxm, m_d
  return mxm

proc part2(input: string): int=
  var
    mxm = 0
    m_d: rand
  let
    dd = parse(input)
    k = dd.keys().toSeq
    n = k.len

  proc solve(i, rem: int, tmp: var seq[int])=
    if i==1:
      var t = (c: 0, d: 0, f: 0, t: 0, cal: 0)
      let tp = (tmp & rem)
      #echo tp
      for j in 0..<n:
      #  echo dd[k[j]]*tp[j]
        t = t + dd[k[j]]*tp[j]
      #echo t
      #echo absol(t)
      if absol(t)>mxm and t.cal==500:
        mxm = absol(t)
        m_d = t
      #[
          ]#
    else:
      for x in 1..(rem-n+1):
        tmp.add(x)
        solve(i-1, rem-x, tmp)
        discard tmp.pop()


  var tt: seq[int] = @[]
  solve(n, 100, tt)
  echo mxm, m_d
  return mxm



when isMainModule:
  doPart1(part1, "15")
  doPart2(part2, "15")
