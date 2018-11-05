#!/usr/bin/env ruby

data = "EckOstgloaUclxatrxmfUclxrvkuikugfqwobxvKdfeywtqxpdbcgkwCcbomsxxrKdfeywtqxpfhcaxvjclkmubtwafqbgzpdmaafbxvzpjxr"

# find n-grams (4 or longer) and their distance. 
ngrams = []
(0..data.size).each do |a|
  (a+1..data.size).each do |b|
    len = 0
    while data[a+len] == data[b+len]
      len += 1
    end

    if len >= 2
      ngrams << [b - a, data[a...a+len]]
    end
  end
end

# p ngrams


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
