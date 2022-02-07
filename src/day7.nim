include templ
import re, strutils

const
    day = "7"
    test01 = "44430 -> b"
    test02 = "NOT gs -> gt"
    test03 = "dd OR do -> dp"
    test04 = "eg AND ei -> ej"
    test05 = "y AND ae -> ag"
    test06 = "jx AND jz -> ka"
    test07 = "lf RSHIFT 2 -> lg"
    test08 = "gn AND gp -> gq"
    test09 = "z AND aa -> ac"
    test10 = "dy AND ej -> el"
    test11 = "bj OR bi -> bk"
    test12 = "kk RSHIFT 3 -> km"
    test13 = "NOT cn -> co"
type
    # a function to be performed to return vallue for a wire
    wireFuncType = tuple
        op: string # e.g `AND, OR, NOT, RSHIFT, LSHIFT`
        params: array[2, string] # parameters for operation. the last string might be empty
    ## Stores operation to be performed on a wire. could be a.. 
    ## value move: e.g `2344  -> b`, or a, then `isVal` is true
    ## function type: e.g `lf RSHIFT aa -> y`
    wireOperation = tuple
        value: int
        isVal: bool
        wireFunc: wireFuncType
    # Contains the wire and the operation to be performed on it
    wireType = object
        wire: string
        refVal: wireOperation

proc getStrVal(str: string): string =
    return str.split(" -> ")[1]

proc getRefVal(str: string): wireOperation =
    let
        main = str.split(" -> ")[0]

proc parseVal(str: string): wireType =
    let 
        wire_val = str.getStrVal
        wire_ref_val = str.getRefVal

    return wireType(wire: wire_val, refVal: wire_ref_val)


# proc parseOp(input: string): wireType =
#     let
#         AND     = re"AND"
#         OR      = re"OR"
#         NOT     = re"NOT"
#         LSHIFT  = re"LSHIFT"
#         RSHIFT  = re"RSHIFT"
#         VALUE   = re"^\d+"
#     if input.find(VALUE) != -1:
#         return parseVal(input)
#     elif input.find(AND) != -1:
#         return parseAnd(input)
#     elif input.find(OR) != -1:
#         return parseOr(input)
#     elif input.find(NOT) != -1:
#         return parseNot(input)
#     elif input.find(LSHIFT) != -1:
#         return parseLshift(input)
#     elif input.find(RSHIFT) != -1:
#         return parseRshift(input)

proc testParseVal() =
    discard parseVal(test01)
    discard parseVal(test02)
    discard parseVal(test03)
    discard parseVal(test04)
    discard parseVal(test05)
    discard parseVal(test06)
    discard parseVal(test07)
    discard parseVal(test08)

proc test() =
    testParseVal()

when isMainModule:
    # download(day, Cookie)
    # parseOp()
    test()