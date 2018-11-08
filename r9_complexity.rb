#bench(1000000(実行回数)) do sqare1(1000)(関数) end のように使用
def bench(count, &block)
  t1 = Process.times.utime
  count.times do
    yield
  end
  t2 = Process.times.utime
  puts t2 - t1
end

def euclid_algo(x, y)
  while x != 0 && y != 0 do
    if x > y then
      x = x % y
    else
      y = y % x
    end
  end
  if x == 0 then
    return y
  else
    return x
  end
end

def combarray(n, r)
  a = Array.new(n + 1, 0)
  a[0] = 1
  (n + 1).times do |i|
#    0.step(n) do |i|
    i.step(1, -1) do |k|
      a[k] += a[k - 1]
    end
  end
  return a[r]
end

