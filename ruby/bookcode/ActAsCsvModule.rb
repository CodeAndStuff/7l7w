#!/usr/bin/env ruby
#Example from the book

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
        @csv_contents.push(CsvRow.new(@headers,row.chomp.split(',')))
      end
    end

    attr_accessor :headers, :csv_contents

    def each(&block)
      @csv_contents.each do |row|
        block.call row
      end
    end

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

m.each {|row| puts row.CSV}
