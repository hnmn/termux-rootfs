#!/data/data/com.termux/files/usr/bin/env ruby

Dir.open(".").entries.grep(/.aiff$/).each do |inp|
  out = inp.gsub(".aiff", ".wav")
  system("sox #{inp} #{out}")
end

