def hello_world
	print"Hello World\n"
end

def find_ruby
	"Hello Ruby".index("Ruby").to_s+"\n"
end

def print_name(i)
	print "KavsVeigs\n"
end

def print_num(i)
	print i.to_s+"\n"
end

def times_n(f,e)
	i=0
	until i==e
		f.call(i)
		i=i+1
	end
end


hello_world
find_ruby.to_s+"\n"
times_n(method(:print_num),10)
times_n(method(:print_name),10)
