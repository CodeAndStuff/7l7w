#!/usr/bin/env ruby


#Class Tree
#Adapted to work with dictionaries

class Tree
  attr_accessor :children,:node_name

  def initialize(hash={})
    hash.each do |key,value|
      @node_name = key
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

#Open write file with and without code blocks
#Without code block
def saveNoCodeBlock
  file=File::open("data/nocodeblock.txt","w")
  file << "Data in no code block mode\n"
  file.close
end

#With code block
def saveWithCodeBlock
  File::open("data/codeblock.txt","w") do |file|
    file << "Data in code block mode\n"
  end
end

def hashVsArray
  hash1={'pt'=>'Portugal','en'=>'England'}
  array=hash1.to_a

  array.each do |el|
    puts el[0].to_s+"-"+el[1].to_s
  end

  hash2=Hash[array.map {|x| [x[0], x[1]]}]
  hash2.each do |k,v|
    puts k.to_s+"-"+v.to_s
  end
end

def arrayAsDeque
  array=(1..10).to_a
  until array.size ==0
    puts array.shift
  end
end

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

def array16NumbersEachSlice
  (1..16).each_slice(4) do |el|
    p el
  end
end

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

def treeExample
    #Define the hash tree
    treeHash={'grandpa' => { 'dad' => {'child 1' => {}, 'child 2' => {} },
    'uncle' => {'child 3' => {}, 'child 4' => {} } } }
    #Map the dictionary into a tree object
    tree=Tree.new(treeHash)
    #Apply a code block into all the nodes
    tree.visit_all{|t| p t.node_name}
end

saveNoCodeBlock
saveWithCodeBlock
hashVsArray
arrayAsDeque
array16NumbersEach
array16NumbersEachSlice
treeExample
fileGrep("master","data/pattern.txt")
