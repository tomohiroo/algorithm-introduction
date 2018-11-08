#動的計画法：再帰とおんなじ感覚なんだけど、nが小さいものからどんどんストックして行くことで、計算量を減らす

#部屋割り問題
def room(n)
  room_price = Array.new(n + 18, 0)
  room_sel = Array.new(n + 1, 0)
  1.step(n) do |i|
    min = room_price[i - 1] + 5000; s = 1
    if min > room_price[i - 3] + 12000 then
      min = room_price[i - 3] + 12000; s = 3
    end
    if min > room_price[i - 7] + 20000 then
      min = room_price[i - 7] + 20000; s = 7
    end
    if min > room_price[i - 13] + 33000 then
      min = room_price[i - 13] + 33000; s = 13
    end
    if min > room_price[i - 17] + 40000 then
      min = room_price[i - 17] + 40000; s = 17
    end
    room_price[i] = min
    room_sel[i] = s
  end
  a = [room_price[n]]
  p room_sel
  while n > 0 do
    a.push(room_sel[n])
    n -= room_sel[n]
  end
  return a
end

#釣り銭問題
def coins(n)
  coinnumber = Array.new(n + 1, 0)
  coinsel = Array.new(n + 1, 0)
  1.step(n) do |i|
    min = coinnumber[i - 1] + 1; s = 1
    if i > 4 && min > coinnumber[i - 5] + 1 then
      min = coinnumber[i - 5] + 1; s = 5
    end
    if i > 9 && min > coinnumber[i - 10] + 1 then
      min = coinnumber[i - 10] + 1; s = 10
    end
    if i > 24 && min > coinnumber[i - 25] + 1 then
      min = coinnumber[i - 25] + 1; s = 25
    end
    coinnumber[i] = min
    coinsel[i] = s
  end
  a = [coinnumber[n]]
  while n > 0 do
    a.push(coinsel[n])
    n -= coinsel[n]
  end
  return a
end

#障害物なし、斜め移動あり,移動の場合の数
def pathfree(a)
  1.step(a.length - 1) do |i|
    1.step(a[i].length - 1) do |j|
      a[i][j] = a[i - 1][j] + a[i][j - 1] + a[i - 1][j - 1]
    end
  end
  return a[a.length - 1][a[1].length - 1]
end


#a = Array.new(6) do Array.new(8, 0) end
#障害物あり、斜め移動あり
def path(a)
  a[0][4] = a[2][2] = a[3][5] = a[4][1] = -1
  8.times do |i|
    if a[0][i] < 0 then
      break
    end
    a[0][i] = 1
  end
  6.times do |i|
    if a[i][0] < 0 then
      break
    end
    a[i][0] = 1
  end
  1.step(5) do |i|
    1.step(7) do |j|
      if a[i][j] < 0 then
        next
      end
      if a[i - 1][j] > 0 then
        a[i][j] += a[i - 1][j]
      end
      if a[i][j - 1] > 0 then
        a[i][j] += a[i][j - 1]
      end
      if a[i - 1][j - 1] > 0 then
        a[i][j] += a[i - 1][j - 1]
      end
    end
  end
  return a[5][7]
end
