require_relative "../utils/part"



module Day19
  class Part1 < Part

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
    end

    def call
      accepted = @parts.filter {|part| accepted?(part)}
      puts accepted.sum{|part| part["x"] + part["m"] + part["a"] + part["s"]}
    end

    def accepted?(part)
      cur = "in"
      loop do
        cur = @workflows[cur].next_workflow(part)
        return true if cur == "A"
        return false if cur == "R"
      end
    end



    def parse_input
      workflow_text, parts_text = File.open(@file_path).read.chomp.split("\n\n")
      @workflows = {}
      workflow_text.split("\n").each do |line|
        key, logic_text = line.tr("}", "").split("{")
        @workflows[key] = Workflow.new(logic_text)
      end

      @parts = parts_text.split("\n").map do |line|
        part = {}
        bits = line.tr("{}", "").split(",")
        bits.each do |bit|
          key, num = bit.split("=")
          part[key] = num.to_i
        end
        part
      end

    end

  end
end
