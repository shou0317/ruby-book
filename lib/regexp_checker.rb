print 'Text?:'
text = gets.chomp

begin
  print 'Pattern?:'
  pattern = gets.chomp
  regex = Regexp.new(pattern)
  matches = text.scan(regex)
  puts "Matched: #{matches.join(',')}"
rescue => e
  puts "Invalid pattern: #{e.message}"
  retry
end
