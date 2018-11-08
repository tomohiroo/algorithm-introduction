def binsort(a)
  #    カウンター: b[n]にnの個数が入る
  b = Array.new(10, 0)
  10.times do |i|
    a.each_index do |k|
      if a[k] == i then
        b[i] += 1
      end
    end
  end
  n = 0
  10.times do |i|
    b[i].times do
      a[n] = i
      n += 1
    end
  end
  return
end
