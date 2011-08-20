module Tools
  class Die
    attr_accessor :sides
    def initialize sides=20
      @sides = sides
    end

    # Rolls the Die and returns the result as +Fixnum+ if rolls==1 or as +Array+ of +Fixnum+
    # if rolls>1.
    def roll rolls=1
      return simple_roll if rolls==1
      results = Array.new
      rolls.times do
        results << simple_roll
      end
      return results
    end

    # Returns the Die as a string with the format Dx, where x is the number of sides. Example "D6", "D20", "D100", etc.
    def to_s
      return "D#{@sides}"
    end

    # Return true if the dice are equal, i.e. they have the same number of sides.
    def eql? die
      return false if die==nil or die.sides!=@sides
      return true
    end

    private

    #Returns a simple die roll
    def simple_roll
      1 + rand(sides)
    end
  end
end