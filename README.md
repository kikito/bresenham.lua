bresenham.lua
=============

A generic Lua lib that implements Bresenham's line algorithm in two modes:

* `bresenham.los(x0,y0,x1,y1, callback)` returns true if there is a Line Of Sight (or LOS) going
   from x0,y0 to x1,y1. It will iterate over each point in the line, invoking `callback(x,y)` on each point.
   `callback` must return `true` if the point at `x,y` is "traversable" by the line, and false otherwise.
* `bresenham.line(x0,y0,x1,y1, callback)` is similar to `bresenham.los`, except that it returns *two* values.
   The first one is a table of the form `{{x1,y1},{x2,y2} ... {xn,yn}}` with the cells traversed by the algorithm.
   The second return value is `true` if a path was found or `false` if it wasn't. This function is slower than `los`,
   try to use the other one if you need speed.

Example
-------


```
local bresenham = require 'bresenham'

local map = {
  {'#','#','#','#','#','#','#','#'},
  {'#','A',' ',' ',' ','B',' ','#'},
  {'#',' ',' ',' ',' ',' ',' ','#'},
  {'#',' ',' ',' ','#','#','#','#'},
  {'#',' ',' ',' ',' ',' ',' ','#'},
  {'#',' ',' ',' ',' ','G',' ','#'},
  {'#',' ',' ',' ',' ',' ',' ','#'},
  {'#','#','#','#','#','#','#','#'},
}

local function printMap()
  print()
  for x=1,8 do
    print(table.concat(map[x]))
  end
  print()
end

print "Initial map:"

printMap()

local A = bresenham.los(2,2,6,6, function(x,y)
  if map[x][y] == '#' then return false end
  map[x][y] = 'A'
  return true
end)

if A then print("Straight line for A was found:") end

printMap()

local B = bresenham.los(2,6,6,6, function(x,y)
  if map[x][y] == '#' then
    map[x][y] = 'X'
    return false
  end
  map[x][y] = 'B'
  return true
end)

if not B then print("Straight line for B was not found:") end

printMap()
```

This is the expected output:

```
Initial Map:

########
#A   B #
#      #
#   ####
#      #
#    G #
#      #
########

Straight line for A was found:

########
#A     #
# A    #
#  A####
#   A  #
#    A #
#      #
########

Straight line for B was not found:

########
#A   B #
# A  B #
#  A#X##
#   A  #
#    A #
#      #
########

```
