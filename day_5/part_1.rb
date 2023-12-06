require_relative "../utils/part"




module Day5
  class Part1 < Part
    Conversion = Struct.new(:destination, :source)
    class Mapping
      attr_accessor :source, :destination, :ranges

      def initialize(source, destination, ranges)
        @source = source
        @destination = destination
        @ranges = ranges
      end

      def get_next(value)
        range = @ranges.detect { |range| range.source.include?(value) }
        return value if range == nil
        value - range.source.min + range.destination.min
      end
    end

    def call
      locations = @seeds.map do |seed|
        cur = seed
        @mappings.each do |mapping|
          cur = mapping.get_next(cur)
        end
        cur
      end
      puts locations.min
    end

    def parse_input
      groups = File.open(@file_path).read.split("\n\n");
      seed_string = groups.shift()
      @seeds = seed_string.split(": ")[1].split(" ").map(&:to_i)

      @mappings = groups.map do |group_str|
        mapping, range_lines = group_str.split(" map:\n")
        source, destination = mapping.split("-to-")
        ranges = range_lines.split("\n").map do |range_line|
          destination_id, source_id, length = range_line.split(" ").map(&:to_i)

          Conversion.new(Range.new(destination_id, destination_id + length - 1), Range.new(source_id, source_id + length - 1))
        end
        Mapping.new(source, destination, ranges)
      end
    end

  end
end
