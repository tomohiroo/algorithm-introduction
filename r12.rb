# モンテカルロ法でy = x^2 の0-10を積分
def integrand(n)
	count = 0.0
	n.times do
		x = rand() * 10; y = rand() * 100
		if y < x ** 2 then
			count += 1
		end
	end
	ans = 1000.0 * count / n.to_f
	p ans
	# 誤差を返す
	return (1000 / 3 - ans).abs
end

def subvec(h, g, m)
    h.each_index do |i|
        h[i] = h[i] - m*g[i]
    end
end


#連立一次方程式を解く
#ピボット選択なし
def gauss1(a)
    # a[..] は一つの式を表す, n は式の数を表す
    puts 'forward:'; p a
    n = a.length
    # 上の式から順に変数 x_g を消していく (前進消去)。
    0.step(n-2) do |g|
        (g+1).step(n-1) do |h|
            # "h 行目 - (a[h][g]/a[g][g])*g 行目" により、
            # h 行目から変数 x_g を消す。
            subvec(a[h], a[g], a[h][g]/a[g][g].to_f)
        end
        p a
    end
    # 下の式から逆順に変数 x_g の値を求めていく (交代代入)。
    puts 'backward:'
    (n-1).step(0, -1) do |g|
        # 変数 x_g の係数で定数項 (右辺) を割ることで、変数 x_g の値を求める。
        a[g][n] = a[g][n]/a[g][g]
        (g-1).step(0, -1) do |h|
            # "h 行目の定数項 - a[h][g]*変数 x_g の値" により、
            # h 行目に変数 x_g を代入した結果を反映する。
            a[h][n] = a[h][n] - a[h][g]*a[g][n]
        end
        p a
    end
    return a
end


#ピボット選択なし、ガウス・ジョルダン法
def gauss2(a)
    # a[..] は一つの式を表す, n は式の数を表す
    puts 'elimination:'; p a
    n = a.length
    # 各式から変数 x_g を消していく。
    0.step(n-1) do |g|
        0.step(n-1) do |h|
            # g 行目だけ変数 x_g を残す。
            if g != h then subvec(a[h], a[g], a[h][g]/a[g][g].to_f) end
        end
        p a
    end
    # 各式から変数 x_g の値を求めていく。
    puts 'division:'
    0.step(n-1) do |g|
        # 変数 x_g の係数で定数項 (右辺) を割ることで、変数 x_g の値を求める。
        a[g][n] = a[g][n]/a[g][g]
        p a
    end
    return a
end




#ピボット選択あり、ガウス・ジョルダン法
#g列での最大値の位置をkで返す
def selectpivot(a, g, n)
    max = a[g][g].abs; k = g;
    # a[..][g] は変数 x_g の係数を表す。
    (g+1).step(n-1) do |i|
        if a[i][g].abs > max then max = a[i][g].abs; k = i end
    end
    return k
end

#g行目とk行目を交換
def swap(a, g, k)
    x = a[g]; a[g] = a[k]; a[k] = x
end

def gauss3(a)
    # a[..] は一つの式を表す, n は式の数を表す
    puts 'elimination:'
    p a
#    idx: swapの記録用
    n = a.length; idx = Array.new(n) do |t| t end
    # 各式から変数 x_g を消していく。
    0.step(n-1) do |g|
        
        # g 行目の式から係数の絶対値が最大となる変数 x_k を探す。
        # 絶対値の最大が (ほぼ)0 ならば、不定/不能と判断する。
        k = selectpivot(a, g, n)
        if a[k][g].abs < 0.00000001 then return nil end
        # g 行目の式と k 行目の式を入れ替える (idx へ記録を残す)。
        swap(a, g, k); swap(idx, g, k)
        # g 行目だけ変数 x_g を残して他を消去する。
        0.step(n-1) do |h|
            if g != h then subvec(a[h], a[g], a[h][g]/a[g][g].to_f) end
        end
        print a, ' / ', idx; puts
    end
# 各式から変数 x_g の値を求めていく。
    puts 'division:'
    0.step(n-1) do |g|
        a[g][n] = a[g][n]/a[g][g]
    end
    # 式の順番を元に戻して結果を表示
#    0.step(n-1) do |i|
#        0.step(n-1) do |g|
#            if i == idx[g] then print a[g]; break end
#        end
#        puts
#    end
    return a
end

