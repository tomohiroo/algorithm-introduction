def fizzbuzz2 
	100.times do |i|
		if i % 15 == 0 then
			puts("fizzbuzz")
		elsif i % 5 == 0 then
			puts ("buzz")
		elsif i % 3 == 0 then
			puts("fizz")
		else
			puts(i)
		end
	end
end

