require "rufo"

parse_file_name = ARGV[0]
parse_file = File.read parse_file_name

result = File.open(parse_file_name.sub(/\.rbs/, ".rb"), "w+")

parse_file.each_line do |line|
  if line =~ /.+:.+\(.+\) -> .+/
    method_name = line.match(/def .+: \(/)
    result << "# #{line}"
    result << "#{method_name[0].sub(/: \(/, "")}"
    result << "#{line.match(/\(.+: .+\)/)[0].sub(/: \w+/, "")}\n"
    result << "end\n"
  else
    result << line
  end
end

result.close

system("rufo .")
