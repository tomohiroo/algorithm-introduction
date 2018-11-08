def swap(a, i, j)
  x = a[i]; a[i] = a[j]; a[j] = x
  # a[i],a[j] = a[j],a[i] でもできる(rubyのみ、多重代入)
end


def quicksort(a, i, j)
  if j <= i then
    # do nothing
  else
    pivot = a[j]
    s = i
    i.step(j - 1) do |k|
      if a[k] <= pivot then
        swap(a, s, k)
        s += 1
      end
    end
    swap(a, j, s)
    quicksort(a, i, s - 1)
    quicksort(a, s + 1, j)
  end
end
#計算量はO(NlogN)
#もし整列済みだったらめっちゃ遅いー＞pivotをランダムに選ぶと改善

