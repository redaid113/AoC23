require_relative "../utils/part"



module Day20
  class Part2 < Part
    class FlipFlop
      attr_accessor :id, :destinations
      def initialize(id, destinations)
        @id = id
        @state = false
        @destinations = destinations
      end

      def next(pulse, from)
        return [] if pulse == :high
        @state = !@state
        output_pulse = @state ? :high : :low
        return @destinations.map {|dest| [output_pulse, dest, @id]}
      end
    end

    class Conjunction
      attr_accessor :id, :destinations
      def initialize(id, destinations)
        @id = id
        @state = false
        @destinations = destinations
        @recent = {}
      end

      def add_input(from)
        @recent[from] = :low
      end

      def next(pulse, from)
        @recent[from] = pulse

        output_pulse = @recent.each_value.all? {|pulse| pulse == :high} ? :low : :high
        return @destinations.map {|dest| [output_pulse, dest, @id]}
      end
    end

    class Broadcast
      attr_accessor :id, :destinations
      def initialize(id, destinations)
        @id = id
        @destinations = destinations
      end

      def next(pulse, from)
        return @destinations.map {|dest| [pulse, dest, @id]}
      end
    end

    def call
      all_high = ["dh", "mk", "rn", "vf"]
      counts = {}
      for i in 1..5000 do
        pulses = [[:low, "broadcaster", "button"]]
        while pulses.any?
          signal, to, from = pulses.shift

          if signal == :high && counts[from].nil? && all_high.include?(from)
            counts[from] = i
            # puts "here #{i} on #{from}"
          end


          next if @modules[to].nil?
          pulses += @modules[to].next(signal, from)
        end
      end

      puts counts.each_value.reduce(:lcm)

    end



    def parse_input
      @modules = {}
      @modules["button"] = Broadcast.new("button", ["broadcast"])
      conjunctions = []

      @file_lines.each do |line|
        id, out = line.split(" -> ")
        destinations = out.split(", ")
        type = id == "broadcaster" ? "broadcaster" : id.slice!(0)
        case type
        when "broadcaster"
          @modules[id] = Broadcast.new(id, destinations)
        when "%"
          @modules[id] = FlipFlop.new(id, destinations)
        when "&"
          @modules[id] = Conjunction.new(id, destinations)
          conjunctions << id
        end
      end

      @modules.each_value.filter do |m|
        m.destinations
          .filter {|dest| conjunctions.include?(dest)}
          .each {|dest| @modules[dest].add_input(m.id)}
      end
    end

  end
end
