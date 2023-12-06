require_relative "../utils/part"

module Day5
  class Part2 < Part
    Conversion = Struct.new(:destination, :source)

    class Mapping
      attr_accessor :source, :destination, :ranges

      def initialize(source, destination, ranges)
        @source = source
        @destination = destination
        @ranges = ranges
      end

      def get_next_values(values)
        output = []

        while values.length > 0
          value = values.shift()
          @ranges.each do |range|
            min = min_value(range, value)
            max = max_value(range, value)

            next if min == nil || max == nil

            if min > value.begin
              values.push(Range.new(value.begin, min - 1))
            end
            if max < value.end
              values.push(Range.new(max + 1, value.end))
            end

            diff = range.destination.begin - range.source.begin

            output.push(Range.new(min + diff, max + diff))
            value = nil
            break
          end

          if value != nil
            output.push(value)
          end
        end

        output
      end

      def min_value(range, value)
        return value.begin if range.source.include?(value.begin)
        return range.source.begin if value.include?(range.source.begin)
        return nil
      end

      def max_value(range, value)
        return value.end if range.source.include?(value.end)
        return range.source.end if value.include?(range.source.end)
        return nil
      end
    end

    def call
      values = []
      while @seeds.length > 0
        first = @seeds.shift()
        length = @seeds.shift()
        values.push(Range.new(first, first + length - 1))
      end

      @mappings.each do |mapping|
        values = mapping.get_next_values(values)
      end

      puts values.min{|a, b| a.begin <=> b.begin }&.begin
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
