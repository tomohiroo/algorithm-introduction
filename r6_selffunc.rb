# 再帰関数(６章)

# 階乗
def fact(n)
  if n != 0
    return n * fact(n - 1)
  else
    return 1
  end
end

# １−３がnこ並んだ組み合わせを表示
def nest3(n, s)
  if n <= 0
    puts(s)
  else
    1.step(3) do |i|
      nest3(n - 1, s + i.to_s)
    end
  end
end

# nから始まる1~2減少列を打ち出す
def decrall(n, b)
  if n > 1
    b.push(n)
    decrall(n - 1, b)
    decrall(n - 2, b)
    # 再帰の呼び出し元のbにnが追加されるという副作用を防ぐ
    b.pop
  elsif n > 0
    b.push(n)
    decrall(n - 1, b)
    # 再帰の呼び出し元のbにnが追加されるという副作用を防ぐ
    b.pop
  else
    p(b)
  end
end


# 順列   呼び出し例：perm2 [1,2,3],[]
def perm2(a, b)
  if a.length == b.length then
    p(b)
    return
  end
  a.each_index do |i|
    if a[i] == nil then
      # 次の周回に飛ぶ
      next
    end
    x = a[i]; a[i] = nil; b.push(x)
    perm2(a, b)
    a[i] = x; b.pop
  end
end

# 演習6-3
# a. n から始まる単なる減少列 (1~N までの幾つ減ってもよい) を全て打ち出す。
def decrn(n, b)
  if n > 0
    b.push(n)
    n.times do |i|
      decrn(n - 1 - i, b)
    end
    b.pop
  else
    p(b)
  end
end

# b. 配列として渡した値を重複を許してL個並べた列を全ての場合について打ち出す。例えば、「[’a’,
# ’a’, ’b’], 2」であれば、[’a’,’a’] [’a’,’a’] [’a’,’b’] [’a’,’a’] [’a’,’a’] [’a’,’b’]
# [’b’,’a’] [’b’,’a’] [’b’,’b]」を打ち出す。
def comball(l, a, b)
  if l == 0
    p(b)
  else
    a.each_index do |i|
      b.push(a[i])
      comball(l - 1, a, b)
      b.pop
    end
  end
end

# c. 1~n までの値を L 個並べた列を全ての場合について打ち出す (全部で n ^ l 個あるはず)。例えば、
# 「N = 3, L = 2」であれば、[1,1] [1,2] [1,3] [2,1] [2,2] [2,3] [3,1] [3,2] [3,3] の 9 通りを打ち出す。
def comball1(l, n, a)
  if l == 0
    p(a)
  else
    n.times do |i|
      a.push(i + 1)
      comball1(l - 1, n, a)
      a.pop
    end
  end
end







