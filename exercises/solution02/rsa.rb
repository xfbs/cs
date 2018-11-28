#!/usr/bin/env ruby

n = 111791377
e = 3

transmitted = [106894622, 54756549, 49966544]

def encrypt(m, e, n)
  (m ** e) % n
end

grades = [10, 13, 17, 20, 23, 27, 30, 33, 37, 40, 50]
alice = 174458

candidates = grades.map{|g| [g, "#{alice}#{g}"]}.map{|g, m| [g, encrypt(m.to_i, e, n)]}
match = candidates.select{|g, c| transmitted.include? c}.first

puts "Alice's ciphertext war #{match[1]} und sie hat eine #{match[0].to_s.split("").join(',')}."
