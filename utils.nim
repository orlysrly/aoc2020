import algorithm
import macros
import sequtils
import sets
import sugar
import tables

type
  Pair*[T] = tuple
    first, second: T
  V2* = tuple
    x, y: int
  V3* = tuple
    x, y, z: int
  V4* = tuple
    x, y, z, w: int

proc `+`*(lhs: V2, rhs: V2): V2 =
  (lhs.x + rhs.x, lhs.y + rhs.y)

proc get_lines*(): seq[string] =
  result = newSeq[string]()
  var line: string
  while readLine(stdin, line):
    result.add(line)
  return result

iterator split*[T](items: seq[T], is_delim: (T) -> bool): seq[T] =
  var cur = newSeq[T]()
  for item in items:
    if is_delim(item):
      if cur.len > 0:
        yield cur
        cur = @[]
    else:
      cur.add(item)

  if cur.len > 0:
    yield cur

proc sum*[T](items: seq[T]): T =
  items.foldl(a + b)

proc product*[T](items: seq[T]): T =
  items.foldl(a * b)

proc identity*[T](v: T): T = v

proc none*[T](items: seq[T]): bool =
  for i in items:
    if i:
      return false
  return true

proc any*[T](items: seq[T]): bool =
  for i in items:
    if i:
      return true
  return false

proc all*[T](items: seq[T]): bool =
  for i in items:
    if not i:
      return false
  return true

proc rev*(s: string): string =
  result = s
  result.reverse()

proc delete_keys*[A,B](table: TableRef[A,B], keys: openArray[A]) =
  for k in keys:
    table.del(k)

proc delete_keys*[A,B](table: var Table[A,B], keys: openArray[A]) =
  for k in keys:
    table.del(k)

template delete_items*[T](s: var seq[T], ds: untyped) =
  s.keepItIf(it notin ds)

macro cmp_by_idx*(idx: static[int]): untyped =
  result = quote do:
    (a, b) => (if a[`idx`] < b[`idx`]: -1 else: 1)
