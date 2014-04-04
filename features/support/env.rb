require 'baseball_stats'

ORIGINAL_STDOUT = $stdout
$stdout = File.open('./tmp/stdout.txt', 'w+')

at_exit do
  $stdout = ORIGINAL_STDOUT
end
