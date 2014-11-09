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

+	Find out how to access files with and without code blocks. What is the benefit of the code block?


Without the code block the code look like this

	def saveNoCodeBlock
		file=File::open("data/nocodeblock.txt","w")
		file << "Data in no code block mode\n"
		file.close
	end

The same could be obtained with code blocks

	def saveWithCodeBlock
  		File::open("data/codeblock.txt","w") do |file|
    			file << "Data in code block mode\n"
  		end
	end
***

+	How would you translate a hash to an array? Can you translate arrays to hashes?

The following code examples the conversion between the two structures

	def hashVsArray
		hash1={"pt"=>"Portugal","en"=>"England"}
		arr=hash1.to_a		
		arr.each do |el|
			puts el[0].to_s+"-"+el[1].to_s
		end
  		hash2=Hash[arr.map {|x| [x[0], x[1]]}]
  		hash2.each do |k,v|
    			puts k.to_s+"-"+v.to_s
  		end
	end
***

+	You can use Ruby arrays as stacks. What other common data structures do arrays support?

Besides a [**stack**](http://en.wikipedia.org/wiki/Stack) *Last in First Out* mechanism we've got the [**deque**](http://en.wikipedia.org/wiki/Double-ended_queue) 

	def arrayAsDeque
  		arr=(1..10).to_a
  		until array.size ==0
    			puts array.shift
  		end
	end

Here we use the *shift* (method of array class) to pop from the other side of the stack and therefore making this a double ended queue
***

+	Print the contents of an array of sixteen numbers, four numbers at a time, using just each . Now, do the same with each_slice in
Enumerable .

Without the *each_slice* method we must control the iteration by blocks manually as you find here

	def array16NumbersEach
  		i=0
  		a=(1..16).to_a
  		a.each do |x|
    			if i<=3
      				puts a[i*4].to_s+","+a[i*4+1].to_s+","+a[i*4+2].to_s+","+a[i*4+3].to_s
    			end
    			i=i+1
  		end
	end

While this works the mechanism with each_slice is much less verbose 

	def array16NumbersEachSlice
  		(1..16).each_slice(4) do |el|
    			p el
  		end
	end

***

+	The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface. Let the initializer accept a nested structure with hashes and arrays. You should be able to specify a tree like this: {’grandpa’ => { ’dad’ => {’child 1’ => {}, ’child 2’ => {} }, ’uncle’ => {’child 3’ => {}, ’child 4’ => {} } } }.

The only change needed to be able to specify the **Tree** as a dictionary is on the *initializer* so it becomes

	class Tree
		#Define attributes for the nodes
  		attr_accessor :children,:node_name
		
		def initialize(hash={})
			#Forall the dictionary elements
    			hash.each do |key,value|
      			@node_name = key
				#Map the elements into a new Tree object recursively
      				@children = value.map{|k,v| Tree.new(k=>v)}
    			end
  		end

		def visit(&block)
			block.call self
		end

		def visit_all(&block)
			visit(&block)
			children.each {|c| c.visit_all &block}
		end
	end

The following method example the use of the class with the hash object provided as exercise

	def treeExample
		treeHash={'grandpa' => { 'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {}, 'child 4' => {}}}}
		tree=Tree.new(treeHash)
    		tree.visit_all{|t| p t.node_name}
	end

***

+	Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line. You will need to do a simple regular expression match and read lines from a file. (This is surprisingly simple in Ruby.) If you want, include line numbers.

All that is needed is some way of recognize a pattern, this is done with the **Regexp** Ruby object, and to process line by line the document, the method is here

	def fileGrep(pattern, file)
  		lnum=0
  		matches=[]
  		lines=[]
  		File.open(file).each do |l|
    			if [l].grep(Regexp.new(pattern))!=[]
      				lines.push(lnum)
    			end
    		lnum=lnum+1
  		end
		puts "#{lines.size} lines of #{lnum} have the pattern '#{pattern}'"
		puts "lines #{lines}"
	end

***

#####Day 3

+	Modify the CSV application to support an each method to return a
CsvRow object. Use method_missing on that CsvRow to return the value for the column for a given heading.

On day 3 we talk about metaprogramming. We were provided with a book example that build code from a csv file:

	module ActsAsCsv
		def self.included(base)
			base.extend ClassMethods
		end

		module ClassMethods
			def acts_as_csv
				include InstanceMethods
			end
		end
		
		module InstanceMethods
			def read
				@csv_contents = []
				filename = self.class.to_s.downcase + '.txt'
				file = File.new(filename)
				@headers = file.gets.chomp.split(', ' )
				file.each do |row|
					@csv_contents << row.chomp.split(', ' )
				end
			end
		
			attr_accessor :headers, :csv_contents

			def initialize
				read
			end
		end
	end

	class RubyCsv # no inheritance! You can mix it in
		include ActsAsCsv
		acts_as_csv
	end
	
	m = RubyCsv.new
	puts m.headers.inspect
	puts m.csv_contents.inspect

From were we were asked to provide a way to iterate over rows in this way

	m.each do |row|
		puts "#{row.Name} has #{row.Age} years old and is #{row.Sex}"
	end

Note that we are assuming here the csv file with this contents

	Name, Age, Sex
	John,23,Male
	Claire,19,Female
	Arthur,30,Male
	Jack,15,Male

The needed changes involved the creation of  new class

	class CsvRow

  		attr_accessor :row

 		def initialize(headers,row)
    			@headers=headers
    			@row=row
  		end

  		def method_missing name, *args
    			col=name.to_s
    			i=0
    			num=-1
    			pos=0
    			eq=false
    			while i < @headers.length
      				if @headers[i].to_s == col
        				num=i
      				end
      				i=i+1
    			end

    			if num!=-1
      				@row[num]
    			else
      				nil
    			end
  		end
	end

On the book *read* method we need to change row iteration into

	file.each do |row|
		@csv_contents.push(CsvRow.new(@headers,row.chomp.split(',')))
	end

***


