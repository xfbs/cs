#!/usr/bin/env ruby

def encrypt(m, e, n)
  (m ** e) % n
end

messages = [5, 6]
n = 77
e = 6

p messages.map{|m| encrypt(m, e, n)}
