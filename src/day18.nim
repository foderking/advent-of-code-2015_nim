import download, strutils, sequtils, sugar, strscans

func `+`(a,b: bool): int=
  return (if a: 1 else: 0) +  (if b: 1 else: 0)

func `+`(a: int,b: bool): int=
  return a +  (if b: 1 else: 0)

func `+`(b: bool, a: int): int=
  return a +  (if b: 1 else: 0)

proc part1(input: string): int=
  var lights: array[102, array[102, bool]]
  var i = 1
  for line in input.split('\n'):
    var j = 1
    for char in line:
      lights[i][j] = char=='#'
      j.inc
    i.inc

  proc animate(): (array[102, array[102, bool]], int)=
    var
      d =  lights
      k = 0
    for i in 1..100:
      for j in 1..100:
        var n = lights[i-1][j]   +
                lights[i-1][j-1] +
                lights[i-1][j+1] +
                lights[i][j-1]   +
                lights[i][j+1]   +
                lights[i+1][j]   +
                lights[i+1][j-1] +
                lights[i+1][j+1]
        if lights[i][j]:
          d[i][j] = n==2 or n==3
        else:
          d[i][j] = n==3

        k += (if d[i][j]: 1 else: 0)
    d[0][0]   = true
    d[0][101] = true
    d[101][0] = true
    d[101][101] = true

    return (d, k+4)

  var nn: int
  for i in 1..100:
    (lights, nn) = animate()
  return nn

proc part2(input: string): int=
  var lights: array[102, array[102, bool]]
  var i = 1
  for line in input.split('\n'):
    var j = 1
    for char in line:
      lights[i][j] = char=='#'
      j.inc
    i.inc

  proc animate(): (array[102, array[102, bool]], int)=
    var
      d =  lights
      k = 0
    for i in 1..100:
      for j in 1..100:
        var n = lights[i-1][j]   +
                lights[i-1][j-1] +
                lights[i-1][j+1] +
                lights[i][j-1]   +
                lights[i][j+1]   +
                lights[i+1][j]   +
                lights[i+1][j-1] +
                lights[i+1][j+1]
        if i in @[1,100] and j in @[1,100]:
          d[i][j] = true
        elif lights[i][j]:
          d[i][j] = n==2 or n==3
        else:
          d[i][j] = n==3

        k += (if d[i][j]: 1 else: 0)

    return (d, k)

  var nn: int
  for i in 1..100:
    (lights, nn) = animate()
  return nn

when isMainModule:
  doPart1(part1, "18")
  doPart2(part2, "18")
