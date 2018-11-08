#!/usr/bin/env ruby

data = "EckOstgloaUclxatrxmfUclxrvkuikugfqwobxvKdfeywtqxpdbcgkwCcbomsxxrKdfeywtqxpfhcaxvjclkmubtwafqbgzpdmaafbxvzpjxr"

# find n-grams (4 or longer) and their distance. 
def ngrams(data, min=4)
  (1..data.size).map do |offset|
    (0..data.size-offset)
      .map{|pos| data[pos] == data[pos+offset]}
      .chunk(&:itself)
      .map{|c| [c[0], c[1].length]}
      .inject([[false, 0, 0]]){|c,o| c << [o[0], c[-1][1] + o[1], o[1]]}
      .select{|c| c[0] && c[2] >= min}
      .map{|c| [c[1]-c[2], offset, c[2], data[c[1]-c[2], c[2]]]}
  end.flatten(1)
end

ngrams(data).each do |pos, offset, len, word|
  puts "word '#{word}' repeated with offset #{offset} at position #{pos}."
end

def decrypt(key, data)
  key = key.chars.map{|c| c.ord - "A".ord}
  data
    .chars
    .map{|c| [c.upcase.ord - "A".ord, c.upcase == c]}
    .zip(key.cycle)
    .map{|d, k| if d[1] then "A".ord else "a".ord end + (d[0] - k) % 26}
    .map(&:chr)
    .join
end

puts decrypt("BYTES", data)

exit

# find key
keylength = 5
key = []
keylength.times do |pos|
  frequency = Hash.new{|h, k| h[k] = 0}
  data.upcase.split("").each_slice(keylength).map{|s| s[pos]}.compact.each do |chr|
    chr = ("A".bytes[0] + ("E".bytes[0] - chr.bytes[0]) % 26).chr
    frequency[chr] += 1
  end

  letter = frequency.sort_by{|k, v| v}.reverse.first.first
  key << letter
end

key[1] = "Y"
key[3] = "E"

# decrypt
data.split("").each_with_index do |char, index|
  decoded = ("A".bytes[0] + (char.upcase.bytes[0] - "A".bytes[0] + key[index % key.size].bytes[0]) % 26).chr
  print decoded
end
