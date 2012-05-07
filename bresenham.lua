local function los(x0,y0,x1,y1, callback)

  local sx,sy,dx,dy

  if x0 < x1 then
    sx = 1
    dx = x1 - x0
  else
    sx = -1
    dx = x0 - x1
  end

  if y0 < y1 then
    sy = 1
    dy = y1 - y0
  else
    sy = -1
    dy = y0 - y1
  end

  local err, e2 = dx-dy, nil

  if not callback(x0, y0) then return false end

  while not(x0 == x1 and y0 == y1) do
    e2 = err + err
    if e2 > -dy then
      err = err - dy
      x0  = x0 + sx
    end
    if e2 < dx then
      err = err + dx
      y0  = y0 + sy
    end
    if not callback(x0, y0) then return false end
  end

  return true
end

local function line(x0,y0,x1,y1,callback)
  local points = {}
  local count = 0
  local result = los(x0,y0,x1,y1, function(x,y)
    if callback and not callback(x,y) then return false end
    count = count + 1
    points[count] = {x,y}
    return true
  end)
  return points, result
end

return {
  los = los,
  line = line,
}
