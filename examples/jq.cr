require "../src/libjq"

ARGV.size == 2 || abort "Usage:  #{PROGRAM_NAME} <jq filter> <file>"

filter = ARGV[0]
input  = File.read(ARGV[1])

jq = Libjq::Jq.run(filter, input)
puts jq.to_s
