import download, strutils, sequtils, sugar, strscans


#[
you go first
each attack reduces enemy hit points by at least 1
first person at 0 or less hit points loses
damage done is attackers damage score - enemy armor score


damage and armor score starts at zero, but can be increased with items
you can buy as many items as you need

weapon = 1, armor = 0/1, rings = 0/2
]#

type Item =
  tuple[Cost: int, Damage: int, Armor: int]
type Stats =
  tuple[HitPoint: int, Damage: int, Armor: int]

let weapons: seq[Item]  = @[
  (Cost: 8, Damage: 4, Armor: 0),
  (Cost: 10, Damage: 5, Armor: 0),
  (Cost: 25, Damage: 6, Armor: 0),
  (Cost: 40, Damage: 7, Armor: 0),
  (Cost: 74, Damage: 8, Armor: 0),
]
let armor: seq[Item] = @[
  (Cost: 13, Damage: 0, Armor: 1),
  (Cost: 31, Damage: 0, Armor: 2),
  (Cost: 53, Damage: 0, Armor: 3),
  (Cost: 75, Damage: 0, Armor: 4),
  (Cost: 102, Damage: 0, Armor: 5),
]
let rings: seq[Item] = @[
  (Cost: 25, Damage: 1, Armor: 0),
  (Cost: 50, Damage: 2, Armor: 0),
  (Cost: 100, Damage: 3, Armor: 0),
  (Cost: 20, Damage: 0, Armor: 1),
  (Cost: 40, Damage: 0, Armor: 2),
  (Cost: 80, Damage: 0, Armor: 3),
]

iterator pickAtMost1(item: seq[Item]): Item =
  yield (Cost: 0, Damage: 0, Armor: 0)
  for each in item:
    yield each

iterator pick2(item: seq[Item]): Item =
  let n = item.len
  for i in 0..<n:
    for j in i+1..<n:
      yield (
        Cost: item[i].Cost + item[j].Cost,
        Damage: item[i].Damage + item[j].Damage,
        Armor: item[i].Armor + item[j].Armor,
      )

proc join(item1: seq[Item], item2: seq[Item]): seq[Item] =
  var arr = item1
  arr.add item2
  return arr

iterator generateItems(): Item =
  for weapon in weapons:
    for armor in pickAtMost1(armor):
      for ring in pickAtMost1(join(pick2(rings).toSeq,rings)):
        yield (
          Cost: weapon.Cost + armor.Cost + ring.Cost,
          Damage: weapon.Damage + armor.Damage + ring.Damage,
          Armor: weapon.Armor + armor.Armor + ring.Armor,
        )


#[
  damage = max(1, attackerDamageScore - enemyArmorScore)
  enemyNewHitPoints = previousHitScore - damage
]#
proc hit(attackDamage: int, defendArmor: int, defendHitPoints: int): int =
  return defendHitPoints - max(1, attackDamage - defendArmor)

proc play(attackerStats: Stats, defenderStats: Stats, isPlayer = true): bool =
  let newEnemyHitPoint = hit(attackerStats.Damage, defenderStats.Armor, defenderStats.HitPoint)
  #echo "The player deals ", attackerStats.Damage, "-", defenderStats.Armor, " = damage; the ", (if isPlayer: "boss" else: "player"), " goes down to ", newEnemyHitPoint, " hit points."
  if newEnemyHitPoint > 0:
    return play(
      (HitPoint: newEnemyHitPoint, Damage: defenderStats.Damage, Armor: defenderStats.Armor),
      attackerStats,
      not isPlayer
    )
  else:
    return isPlayer

proc serializeStat(input: string): Stats =
  let x = input.splitLines(false).map(each => each.split(": ")[1])
  return (HitPoint: x[0].parseInt(), Damage: x[1].parseInt(), Armor: x[2].parseInt())

proc part1(input: string): string=
  let enemy = serializeStat(input)
  var minCost = int.high()
  for hitem in generateItems():
    #echo hitem
    let playerStat: Stats = (HitPoint: 100, Damage: hitem.Damage, Armor: hitem.Armor) 
    if play(playerStat, enemy, true):
      minCost = min(hitem.Cost, minCost)
  return minCost

proc part2(input: string): string=
  let enemy = serializeStat(input)
  var maxCost = int.low()
  for hitem in generateItems():
    #echo hitem
    let playerStat: Stats = (HitPoint: 100, Damage: hitem.Damage, Armor: hitem.Armor) 
    if not play(playerStat, enemy, true):
      maxCost = max(hitem.Cost, maxCost)
  return maxCost

when isMainModule:
  #echo play((HitPoint: 8, Damage: 5, Armor: 5), (HitPoint: 12, Damage: 7, Armor: 2))
  #echo generateItems().toSeq.len
  partOne(part1, "21")
  partTwo(part2, "21")
  #[
  ]#
