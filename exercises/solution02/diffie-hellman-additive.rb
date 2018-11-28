#!/usr/bin/env ruby


def compute_pub(g, p, sec)
  (g * sec) % p
end

def compute_key(g, p, pub, sec)
  (pub * sec) % p
end

p = 13
g = 6


pub_x = 2
pub_y = 3

sec_x = (1..p).select{|n| compute_pub(g, p,  n) == pub_x}
p sec_x
exit

k = compute_key(g, p, pub_y, sec_x)

puts "x is #{sec_x} and the key is #{k}."
