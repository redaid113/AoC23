require_relative "../utils/part"



module Day19
  class Part2 < Part

    class Rule
      attr_accessor :char, :symbol, :number, :success, :end_condition

      def initialize(text)
        @text = text
        bits = text.split(":")
        if bits.length == 1
          @end_condition = true
          @success = bits[0]
        else
          @end_condition = false
          @success = bits[1]

          @char = bits[0].slice!(0)
          @symbol = bits[0].slice!(0)
          @number = bits[0].to_i
        end
      end

      def passes?(part)
        return true if end_condition

        return part[@char] > number if symbol == ">"
        return part[@char] < number if symbol == "<"
        return false
      end

      def to_s
        @text
      end
    end

    class Workflow
      attr_accessor :rules

      def initialize(text)
        groups = text.split(",")
        @rules = groups.map {|group| Rule.new(group)}
      end

      def next_workflow(part)
        found = @rules.find {|rule| rule.passes?(part)}
        found.success
      end

      def get_parts(part)
        parts = []
        @rules.each do |rule|
          if rule.end_condition
            parts << [rule.success, part]
            next
          end
          p_range = part[rule.char]
          if p_range[0] > rule.number && rule.symbol == ">"
            parts << [rule.success, part]
            break
          end

          if p_range[1] < rule.number && rule.symbol == ">"
            parts << [rule.success, part]
            break
          end

          if p_range[0] <= rule.number && p_range[1] >= rule.number
            new_part = part.clone
            if rule.symbol == ">"
              new_part[rule.char] = [rule.number + 1, p_range[1]]
              part[rule.char] = [p_range[0], rule.number]
            else
              new_part[rule.char] = [p_range[0], rule.number - 1]
              part[rule.char] = [rule.number, p_range[1]]
            end
            parts << [rule.success, new_part]
          end
        end
        parts
      end
    end

    def call
      parts = [["in", {"x" => [1, 4000], "m" => [1, 4000], "a" => [1, 4000], "s" => [1, 4000]}]]
      accepted = []
      while parts.length > 0 do
        key, part = parts.shift

        new_parts = @workflows[key].get_parts(part)
        new_parts.each do |new_key, new_part|
          parts << [new_key, new_part] if new_key != "A" && new_key != "R"
          accepted << new_part if new_key == "A"
        end

      end

      puts accepted.sum{|part| (part["x"][1] - part["x"][0] + 1) * (part["m"][1] - part["m"][0] + 1) * (part["a"][1] - part["a"][0] + 1) * (part["s"][1] - part["s"][0] + 1)}
    end




    def parse_input
      workflow_text, parts_text = File.open(@file_path).read.chomp.split("\n\n")
      @workflows = {}
      workflow_text.split("\n").each do |line|
        key, logic_text = line.tr("}", "").split("{")
        @workflows[key] = Workflow.new(logic_text)
      end
    end
  end
end
