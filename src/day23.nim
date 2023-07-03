import download, strutils, sequtils, sugar, strscans, tables

type Instruction = tuple[Type: string, Value: string] # seq[(string, string)]

proc serializeInput(input: string): seq[Instruction] =
  return 
    input
    .splitLines()
    .map(each => each.split(" ", 1))
    .map(each => (Type: each[0], Value: each[1]))

proc evaulateInstruction(instrIndex: int, instruction: Instruction, memory: Table[string, int]): (int, string, int)=
  case instruction.Type:
    of "hlf": 
      return (instrIndex+1, instruction.Value, memory[instruction.Value] div 2)

    of "tpl":
      return (instrIndex+1, instruction.Value, memory[instruction.Value] * 3)

    of "inc":
      return (instrIndex+1, instruction.Value, memory[instruction.Value] + 1)

    of "jmp":
      return (instrIndex + instruction.Value.parseInt(), "null", -1)

    of "jie":
      let tmp = instruction.Value.split(", ")
      let (register, offset) = (tmp[0], tmp[1].parseInt())

      if memory[register] mod 2 == 0:
        return (instrIndex + offset, "null", -1)
      else:
        return (instrIndex + 1, "null", -1)

    of "jio":
      let tmp = instruction.Value.split(", ")
      let (register, offset) = (tmp[0], tmp[1].parseInt())

      if memory[register] == 1:
        return (instrIndex + offset, "null", -1)
      else:
        return (instrIndex + 1, "null", -1)
    else:
      raiseAssert("error")


proc runProgram(memory: var Table[string, int], instructions: seq[Instruction], index: int, n: int): void =
  if index >= n:
    return
  else:
    let (nextIndex, register, value) = evaulateInstruction(index, instructions[index], memory)
    memory[register] = value
    runProgram(memory, instructions, nextIndex, n)


proc part1(input: string): int=
  let instructions = serializeInput(input)
  var mem = { "a": 0, "b": 0}.toTable()
  runProgram(mem, instructions, 0, instructions.len())
  return mem["b"]

proc part2(input: string): int=
  let instructions = serializeInput(input)
  var mem = { "a": 1, "b": 0}.toTable()
  runProgram(mem, instructions, 0, instructions.len())
  return mem["b"]

when isMainModule:
  partOne(part1, "23")
  partTwo(part2, "23")
