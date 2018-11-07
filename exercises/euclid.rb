#!/usr/bin/env ruby

def euclid(a, b)
  res = if b == 0 then a else euclid(b, a % b) end
  puts "euclid(#{a}, #{b}) = #{res}"
  res
end

euclid(595, 429)
