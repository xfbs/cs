#!/usr/bin/env ruby
require "matrix"

# all 4x4 invertible bit matrices
matrices = (2**16)
  .times
  .map{|n| n.to_s(2).rjust(16,'0')}
  .map{|n| n.chars.map{|c| c.to_i}}
  .map{|n| Matrix[n[0,4], n[4,4], n[8,4], n[12,4]]}
#  .select{|n| n.det != 0}

#matrices = [
#  Matrix[[1, 0, 1, 0], [0, 1, 1, 1], [1, 1, 0, 0], [0, 1, 0, 1]]]

# all possible 4-bit bitstrings
bitstrings = (2**4)
  .times
  .map{|n| n.to_s(2).rjust(4, '0')}
  .map{|n| n.chars.map{|c| c.to_i}}
  .map{|n| Vector[*n]}

#bitstrings = [Vector[1, 0, 1, 0]]

# known plaintext and ciphertexts
data = {
  Vector[0, 0, 0, 0] => Vector[1, 0, 1, 0],
  Vector[0, 0, 0, 1] => Vector[1, 1, 1, 1],
  Vector[0, 0, 1, 1] => Vector[0, 0, 1, 1],
  Vector[0, 1, 1, 1] => Vector[0, 1, 0, 0],
  Vector[1, 1, 1, 1] => Vector[1, 1, 1, 0]}

matrices.each do |matrix|
  bitstrings.each do |bitstr|
    puts "yay" if data
      .all?{|msg, cipher|
        k = (matrix*msg).map{|m| if m.zero? then 0 else 1 end}
        c = (bitstr - k).map(&:abs)
        c == cipher}
  end
end

