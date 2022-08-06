import download
import strutils, strscans, tables


proc calc(active, passive, total, speed: int): int=
  let
    fact = total div (active+passive)
    rem  = total mod (active+passive)

  return speed * (fact*active + min(rem, active))

proc part1(input: string) =
    echo "[+] Part 1"
    let tot = 2503
    var
      pers: string
      speed, active, passive: int
      mxm = low(int32).int
    for line in input.split('\n'):
      if scanf(line, "$+ can fly $i km/s for $i seconds, but then must rest for $i seconds.",
               pers, speed, active, passive):
        let ans = calc(active, passive, tot, speed)
        mxm = max(mxm,  ans)
        #echo pers, " ", ans

      else:
        echo line
        raiseAssert("")
    echo mxm

proc part2(input: string) =
    echo "[+] Part 2"
    let tot = 2503
    var
      pers: string
      speed, active, passive: int
      mxm = low(int32).int
      dict: Table[string, tuple[speed: int, active: int, passive: int, dist: int, point: int]]
      points: Table[string, int]
    for line in input.split('\n'):
      if scanf(line, "$+ can fly $i km/s for $i seconds, but then must rest for $i seconds.",
               pers, speed, active, passive):
        dict[pers] = (speed, active, passive, 0, 0)
        points[pers] = 0
      else:
        echo line
        raiseAssert("")

    var
      mxm_dist: int
      mxm_pers: seq[string]
      mxm_points: int
    
    mxm_dist = 0
    mxm_pers = @[]

    for t in 0..<tot:
      for each in dict.keys():
        if (t mod (dict[each].active + dict[each].passive) )+1 <= dict[each].active:
          dict[each].dist += dict[each].speed
          if dict[each].dist > mxm_dist:
            mxm_dist = dict[each].dist
            mxm_pers = @[each]
          elif dict[each].dist == mxm_dist:
            mxm_pers.add(each)
      for per in mxm_pers:
        points[per].inc
        mxm_points = max(mxm_points, points[per])

    echo dict
    echo points
    echo mxm_points

when isMainModule:
    let d =  download("14")
    #part1(d)
    part2(d)
