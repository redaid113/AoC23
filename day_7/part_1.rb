require_relative "../utils/part"

module Day7
  class Part1 < Part

    class Card
      attr_accessor :value
      def initialize(value)
        @value = value
      end

      Order = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
      def <=>(other)
        Order.index(@value) <=> Order.index(other.value)
      end

      def hash
        Order.index(@value)
      end

      def eql?(other)
        @value == other.value
      end

      def ==(other)
        self.eql?(other)
      end
    end

    class Hand
      attr_accessor :cards, :score

      def initialize(cards, score)
        @cards = cards
        @score = score
        @uniq_cards = cards.uniq
      end


      Order = [:five_of_a_kind, :four_of_a_kind, :full_house, :three_of_a_kind, :two_pair, :pair, :high_card]
      def type
        if five_of_a_kind?
          return :five_of_a_kind
        elsif four_of_a_kind?
          return :four_of_a_kind
        elsif full_house?
          return :full_house
        elsif three_of_a_kind?
          return :three_of_a_kind
        elsif two_pair?
          return :two_pair
        elsif pair?
          return :pair
        else
          return :high_card
        end
      end

      def five_of_a_kind?
        @uniq_cards.length == 1
      end

      def four_of_a_kind?
        @uniq_cards.length == 2 && (@cards.count(@cards[0]) == 4 || @cards.count(@cards[1]) == 4)
      end

      def full_house?
        @uniq_cards.length == 2
      end

      def three_of_a_kind?
        @uniq_cards.length == 3 && (@cards.count(@cards[0]) == 3 || @cards.count(@cards[1]) == 3 || @cards.count(@cards[2]) == 3)
      end

      def two_pair?
        @uniq_cards.length == 3
      end

      def pair?
        @uniq_cards.length == 4
      end

      def <=>(other)
        cur_index = Order.index(self.type)
        other_index = Order.index(other.type)

        if cur_index == other_index
          @cards.each_with_index do |card, index|
            other_card = other.cards[index]
            if card != other_card
              return card <=> other_card
            end
          end
        end

        return cur_index <=> other_index
      end

      def to_s
        @cards.map(&:value).join("")
      end
    end


    def call

      @hands.sort!.reverse!

      puts @hands.each_with_index.map { |hand, index| (index+1)*hand.score }.inject(:+)
    end



    def parse_input
      @hands = @file_lines.map do |line|
        cards_str, score_str = line.split(" ")
        cards = cards_str.split("").map { |c| Card.new(c) }
        score = score_str.to_i
        Hand.new(cards, score)
      end
    end

  end
end
