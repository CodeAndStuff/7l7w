#!/usr/bin/env ruby
#Example from the book

class ActsAsCsvClass

    def read
      file = File.new(self.class.to_s.downcase + '.txt' )
      @headers = file.gets.chomp.split(', ' )
      file.each do |row|
        @result << row.chomp.split(', ' )
      end
    end

    def headers
      @headers
    end

    def csv_contents
      @result
    end

    def initialize
      @result = []
      read
    end
end

class RubyCsv < ActsAsCsvClass
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
