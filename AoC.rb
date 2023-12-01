require_relative "./run"

day = ARGV.shift()

part1 = !ARGV.include?('--part_2')
part2 = !ARGV.include?('--part_1')

ARGV.delete('--part_1')
ARGV.delete('--part_2')

input_file = ARGV.shift()

file_path = "#{__dir__}/#{day}/#{input_file}"

Run.call(day: day, part1: part1, part2: part2, file_path: file_path)
