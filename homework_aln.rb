def aln1(s, t)
  a = Array.new(t.length + 1) do |i|
    Array.new(s.length + 1) do |j|
      -2 * (i + j)
    end
  end
  1.step(t.length) do |i|
    1.step(s.length) do |j|
      val = -1
      if s[j - 1] == t[i - 1] then
        val = a[i - 1][j - 1] + 2
      else
        val = a[i - 1][j - 1] - 1
      end
      if j > 1 && i > 1 && s[j - 2] == t[i - 1] && s[j - 1] == t[i - 2] && a[i - 2][j - 2] + 1 > val then
        val = a[i - 2][j - 2] + 1
      end
      if a[i][j - 1] - 2 > val then
        val = a[i][j - 1] - 2
      end
      if a[i - 1][j] - 2 > val then
        val = a[i - 1][j] - 2
      end
      a[i][j] = val
    end
  end
  return a[t.length][s.length]
end
