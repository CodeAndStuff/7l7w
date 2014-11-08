#7L7W
## Seven Languages Seven Weeks
### Description
This is a repository with the exercises purposed by the book

##Code
###Ruby
####Instalation

To install ruby on a debian machine just run

	sudo apt-get install ruby

To run the interpreter and develop in an interactive way you could run

	user@machine> irb

And start to type some code

	irb(main):001:0> a=12
	=> 12

####Ruby File

To run the file from the shell you can do

	ruby file.rb

Or you can tell the shell to prepend the ruby interpreter with

	#!/usr/bin/env ruby

on the beginning of the file

And then set the file to executable mode

	chmod +x file.rb




***
####Exercises
#####Day 1

+	Print the string **hello world**

***

	def hello_world()
		print "Hello World\n"
	end
***

+	For the string **Hello Ruby** find the index of the word **Ruby**

***
	def find_ruby
		"Hello Ruby".index("Ruby").to_s+"\n"
	end
***

+	Print your name ten times

***
Considering the functional method 
	
	def times_n(f,e)
		i=0
		until i==e
			f.call(i)
			i=i+1
		end
	end

And the callback

	def print_name(i)
		print "Seven Languages Seven Weeks\n"
	end

We can do

	times_n(method(:print_name),10)
***

+	Print the string **This is sentence number 1**, where the number 1
changes from 1 to 10.
***

Defining the callback

	def print_num(i)
		print "This is sentence number: "+i.to_s+"\n"
	end

we can call

	times_n(method(:print_num),10)

***

+	**Bonus problem**: If you’re feeling the need for a little more, write
a program that picks a random number. Let a player guess the
number, telling the player whether the guess is too low or too high.

***
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

And then call **guessWhat()**
***

#####Day 2

