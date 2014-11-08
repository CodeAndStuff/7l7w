#!/usr/bin/env ruby

#Exercises from 7 Languages 7 Weeks
#Day 1

def hello_world
	print"Hello World\n"
end

def find_ruby
	"Hello Ruby".index("Ruby").to_s+"\n"
end

def print_name(i)
	print "Seven Languages Seven Weeks\n"
end

def print_num(i)
	print "This is sentence number: "+i.to_s+"\n"
end

def times_n(f,e)
	i=0
	until i==e
		f.call(i)
		i=i+1
	end
end

def guessWhat()
	guess=rand(10)
	solution="-1"
	puts "Find the number between 0 and 9"
	until solution.to_i==guess
		solution=gets.chomp
		if solution.to_i < guess
			puts "Too low"
		else
			puts "Too high"
		end
	end
	puts "Congratulation you find it"
end


hello_world
find_ruby
times_n(method(:print_name),10)
times_n(method(:print_num),10)
guessWhat()
