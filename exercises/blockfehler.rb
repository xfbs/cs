require "openssl"

# data (four blocks big)
data = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ;"

# encrypt data
cipher = OpenSSL::Cipher::AES.new(128, :CBC)
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
encrypted = cipher.update(data) + cipher.final
orig_enc = encrypted.dup

# mutate first block of cipher
12.times do
  char = rand(16)
  bit  = rand(8)
  encrypted[char] = (encrypted[char].bytes.first ^ (1 << bit)).chr
end

# decrypt data
decipher = OpenSSL::Cipher::AES.new(128, :CBC)
decipher.decrypt
decipher.key = key
decipher.iv = iv
plain = decipher.update(encrypted) + decipher.final

# analyze resulting plaintext
plain.bytes.zip(data.bytes).each_slice(16).each_with_index do |block, count|
  diffs = 0
  block.each do |bytepair|
    diffs += (0..8)
      .map{|bit| bit = (1 << bit); (bytepair[0] & bit) ^ (bytepair[1] & bit) != 0}
      .inject(0){|a,b| if b then a + 1 else a end}
  end
  puts "block #{count}: #{diffs}"
end
