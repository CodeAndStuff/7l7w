#!/usr/bin/env ruby

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
  array=hash1

  array.each do |el|
    puts el[0].to_s+"-"+el[1].to_s
  end

  hash2=Hash[array.map {|x| [x[0], x[1]]}]
  hash2.each do |k,v|
    puts k.to_s+"-"+v.to_s
  end
end

saveNoCodeBlock
saveWithCodeBlock
hashVsArray
