$x = 0
$list = []
$sx = 0
$slist = []


def sum(v)
  $x = $x + v
  $list.push(v)
  return $x
end

def reset
  $sx = x
  $x = 0
  $slist = $list
  $list = []
  return $x
end

def dec(d)
  $x -= d
  $list.push(-d)
  return $x
end


def list
  p($list, $x)
end

def undo
  $x = $y
  $list = $slist
  return $x
end