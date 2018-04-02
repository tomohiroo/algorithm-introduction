
  　Pixel = Struct.new(:r, :g, :b)
  $img = Array.new(200) do Array.new(300) do Pixel.new(255,255,255) end end

  def pset(x, y, r, g, b)
    if 0 <= x && x < 300 && 0 <= y && y < 200 then
      $img[y][x].r = r; $img[y][x].g = g; $img[y][x].b = b
    end
end

  def writeimage(name)
    open(name, "wb") do |f|
      f.puts("P6\n300 200\n255")
      $img.each do |a|
        a.each do |p|
          f.write(p.to_a.pack('ccc'))
        end 
      end
    end
  end

  def mypicture
    pset(100, 80, 255, 0, 0)
    writeimage('t.ppm')
  end

  def fillcircle(x0, y0, rad, r, g, b)
    200.times do |y|
      300.times do |x|
        if (x-x0)**2 + (y-y0)**2 <= rad**2 then
          pset(x, y, r, g, b)
        end
      end
    end
    writeimage('circle.ppm')
  end


  def fillellipse(x, y, rx, ry, r, g, b)
    j0 = (y-ry).to_i; j1 = (y+ry).to_i
    i0 = (x-rx).to_i; i1 = (x+rx).to_i
    j0.step(j1) do |j|
      i0.step(i1) do |i|
        if (i-x).to_f**2/rx**2 + (j-y).to_f**2/ry**2 < 1.0 then
          pset(i, j, r, g, b)
        end
      end
    end
    writeimage('fillellipse.ppm')
  end


  def filltriangle(x0, y0, x1, y1, x2, y2, r, g, b)
    fillconvex([x0, x1, x2, x0], [y0, y1, y2, y0], r, g, b, "triangle")
end

  def fillconvex(ax, ay, r, g, b, name)
    xmax = ax.max.to_i; xmin = ax.min.to_i
    ymax = ay.max.to_i; ymin = ay.min.to_i
    ymin.step(ymax) do |j|
      xmin.step(xmax) do |i|
       if isinside(i, j, ax, ay) then pset(i, j, r, g, b) end
end end
    writeimage(name.to_s + '.ppm')

end

def isinside(x, y, ax, ay)
    (ax.length-1).times do |i|
      if oprod(ax[i+1]-ax[i], ay[i+1]-ay[i], x-ax[i], y-ay[i]) < 0 then
        return false
end end
    return true
  end

  # 外積
  def oprod(a, b, c, d)
    return a*d - b*c;
end

 def fillline(x0, y0, x1, y1, w, r, g, b)
    dx = y1-y0; dy = x0-x1
    n = 0.5*w / Math.sqrt(dx**2 + dy**2)
    dx = dx * n; dy = dy * n
    fillconvex([x0-dx, x0+dx, x1+dx, x1-dx, x0-dx],
               [y0-dy, y0+dy, y1+dy, y1-dy, y0-dy], r, g, b, "line")
  end






   