#lcs: 最長共通部分列
def lcs1(s, t)
#     答え保持
  c_max = 0
  0.step(s.length - 1) do |i|
#        tの対応づけを始めるのの一個前をlm、s[j]を考える
    c = 0; lm = -1; j = i
    while (j <= s.length - 1 && lm <= t.length - 2) do
#            t[k]を考える
      k = lm + 1
      while (k <= t.length - 1) do
        if s[j] == t[k] then
          lm = k; j += 1; k += 1; c += 1;
          if j >= s.length then
            break
          end
        else
          k += 1
        end
      end
      j += 1
    end
    if c > c_max then
      c_max = c
    end
  end
  return c_max
end


def lcs2(s, t)
  a = Array.new(t.length + 1) do
    Array.new(s.length + 1, 0)
  end
#    配列の中で−1したいので１から始める
  1.step(t.length) do |i|
    1.step(s.length) do |j|
#            そこまでのlcs保持
      val = -1
      if s[j - 1] == t[i - 1] then
        val = a[i - 1][j - 1] + 1;
      end
      if a[i][j - 1] > val then
        val = a[i][j - 1]
      end
      if a[i - 1][j] > val then
        val = a[i - 1][j]
      end
      a[i][j] = val
    end
  end
#    p a
  return a[t.length][s.length]
end


#最長部分文字列も出力
def lcstrace(s, t)
  # まずは、動的計画法により LCS 値の表 (盤面) を作成する。
  a = Array.new(t.length + 1) do
    Array.new(s.length + 1, 0)
  end
  1.step(t.length) do |i|
    1.step(s.length) do |j|
      val = -1
      if s[j - 1] == t[i - 1] then
        val = a[i - 1][j - 1] + 1
      end
      if a[i][j - 1] > val then
        val = a[i][j - 1]
      end
      if a[i - 1][j] > val then
        val = a[i - 1][j]
      end
      a[i][j] = val
    end
  end
  #ここまでは同じ
  # 作成した LCS 値の表 (盤面) の右下端から、
  # 各マス毎にどの規則を適用したかを調べながら「逆向きに」辿っていく。
  i = t.length; j = s.length
  ord = Array.new(i * j); abs = Array.new(i * j); c = 0
  ord[c] = i; abs[c] = j; c += 1
  while i >= 0 && j >= 0 do
    if s[j - 1] == t[i - 1] && a[i][j] == (a[i - 1][j - 1] + 1) then
      ord[c] = i - 1; abs[c] = j - 1; c += 1
      i -= 1; j -= 1
    elsif a[i][j] == a[i][j - 1] then
      ord[c] = i; abs[c] = j - 1; c += 1
      j -= 1
    else # a[i][j] == a[i-1][j]
      ord[c] = i - 1; abs[c] = j; c += 1
      i -= 1
    end
  end
  # トレースバックした結果 (辿ったマスの座標) は (abs[], ord[]) として表せる。
  0.step(c - 3) do |k|
    print '(', abs[k], ', ', ord[k], ') -> '
  end
  print '(', abs[c - 2], ', ', ord[c - 2], ')'; puts
  # 最長部分文字列を見やすい形に整形して表示する。
  ns = ''; 1.step(s.length) do
    ns = ' ' + ns
  end # ns:文字列 s で対応する文字の番号を記録
  nt = ''; 1.step(t.length) do
    nt = ' ' + nt
  end # nt:文字列 t で対応する文字の番号を記録
  d = 0 # 対応する文字のカウンタ

  (c - 2).step(1, -1) do |k|
    if ((ord[k] - ord[k - 1]) == -1 && (abs[k] - abs[k - 1]) == -1) then
      d += 1
      ns[abs[k]] = d.to_s; nt[ord[k]] = d.to_s
    end
  end
  puts s; puts ns; puts nt; puts t
end


#//////////////////////////////////////////////////////////////////////
def lcs2(s, t)
  a = Array.new(t.length + 1) do
    Array.new(s.length + 1, 0)
  end
  #    配列の中で−1したいので１から始める
  1.step(t.length) do |i|
    1.step(s.length) do |j|
      #            そこまでのlcs保持
      val = -1
      if s[j - 1] == t[i - 1] then
        val = a[i - 1][j - 1] + 1;
      end
      if a[i][j - 1] > val then
        val = a[i][j - 1]
      end
      if a[i - 1][j] > val then
        val = a[i - 1][j]
      end
      a[i][j] = val
    end
  end
  #    p a
  return a[t.length][s.length]
end

#//////////////////////////////////////////////////////////////////////

def aln(s, t)
#    端っこを考えて−２していく
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


def aln1 s, t
  a = Array.new(t.length + 1) { |i| Array.new(s.length + 1) { |j| -2 * (i + j) } }
  1.step(t.length) do |i|
    1.step(s.length) do |j|
      val = -1
      if s[j - 1] == t[i - 1]
        val = a[i - 1][j - 1] + 2
      else
        val = a[i - 1][j - 1] - 1
      end
      if j > 1 && i > 1 && s[j - 2] == t[i - 1] && s[j - 1] == t[i - 2] && a[i - 2][j - 2] + 1 > val
        val = a[i - 2][j - 2] + 1
      end
      val = a[i][j - 1] - 2 if a[i][j - 1] - 2 > val
      val = a[i - 1][j] - 2 if a[i - 1][j] - 2 > val
      a[i][j] = val
    end
  end
  return a[t.length][s.length]
end