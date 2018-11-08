# section6

# 交換
def swap(a, i, j)
  x = a[i]; a[i] = a[j]; a[j] = x
  # a[i],a[j] = a[j],a[i] でもできる(rubyのみ、多重代入)
end


# bubblesort(昇順)
def bubblesort(a)
  done = false
  while !done do
    done = true
    0.step(a.length - 2) do |i|
      if a[i] > a[i + 1] then
        swap(a, i, i + 1); done = false
      end
    end
  end
  return(a)
end


# 単純選択法（昇順）
def selectionsort(a)
  # 最小のやつは余る
  0.step(a.length - 2) do |i|
    k = arrayminrange(a, i, a.length - 1); swap(a, i, k)
  end
end

# 最小の数の位置を返す
def arrayminrange(a, i, j)
  p = i; min = a[p]
  i.step(j) do |k|
    if min > a[k] then
      p = k; min = a[k]
    end
  end
  return p
end


# 単純挿入法(昇順)
def insertionsort(a)
  1.step(a.length - 1) do |i|
    x = a[i]; k = 0
    while k < i && a[k] <= x do
      k += 1
    end
    arrayshiftrange(a, k, i - 1); a[k] = x
  end
  return(a)
end

# iからj番めまでを一個ずつ後ろにずらす
def arrayshiftrange(a, i, j)
  # 後ろからやる
  j.step(i, -1) do |k|
    a[k + 1] = a[k]
  end
end


# マージソート（早い）:配列 a の i 番(a[i])から j 番(a[j])の範囲を整列
def mergesort(a, i, j)
#    副列の長さが 1 以下の時
  if j <= i then
#       do nothing
  else
#        kはint->切り捨て
    k = (i + j) / 2
    mergesort(a, i, k)
    mergesort(a, k + 1, j)
#        再帰から帰って来た
    b = merge(a, i, k, a, k + 1, j)
    b.length.times do |l|
      a[i + l] = b[l]
    end
  end
  return(a)
end

# マージ: a1[i1], ..., a1[j1] と a2[i2], ..., a2[j2] を併合した配列bを返す
def merge(a1, i1, j1, a2, i2, j2)
  b = []
#    i1, ..., j1 と i2, ..., j2 の少なくとも一方が空でない間、
  while i1 <= j1 || i2 <= j2 do
#        もし i1, ..., j1 が空 または a1[i1] > a2[i2] なら、
    if i1 > j1 || i2 <= j2 && a1[i1] > a2[i2] then
      b.push(a2[i2])
      i2 += 1
    else
      b.push(a1[i1])
      i1 += 1
    end
  end
  return b
end







