class Tools::Throw
  attr_accessor :dice, :offset
  
  def initialize dice, offset=0
    @dice = dice.sort_by{|die| die.sides}
    @offset = offset
  end
  
  # Rolls the Throw and returns the result in different ways according to the params. 
  # If +detailed=false+ it will call +simple_roll+ and +detailed_roll+ in case of +true+.
  # Refer to these methods for more info of the format.  
  # Returns the result as +simple_roll/detailed_roll+ if rolls==1 or as +Array+ of 
  # +simple_roll/detailed_roll+ if rolls>1.
  def roll rolls=1, detailed=false
    return simple_roll if rolls==1 and !detailed
    return detailed_roll if rolls==1 and detailed
    results = Array.new
    rolls.times do 
      results << simple_roll if !detailed
      results << detailed_roll if detailed
    end
    return results
  end  
  
  # Returns the Trhow as a string with the format aDx,bDy,cDz+n, where a,b,c are the number of dice,
  # x,y,z are the number of sides and n the offset. Example "D6,D20,D100+8", etc.
  def to_s
    throw_dice_number = Array.new
    throw_dice = Array.new
    temp_dice = dice.sort_by{|die| die.sides}    
    last_die = nil
    temp_dice.each do |temp_die|
      if !temp_die.eql? last_die
        last_die = temp_die
        throw_dice << temp_die
        throw_dice_number << temp_dice.count{|die| die.eql? temp_die}
      end
    end
    throw_string = ""
    throw_dice.each_index do |i|
      throw_string << "," if i>0
      throw_string << throw_dice_number[i].to_s + throw_dice[i].to_s
    end
    throw_string << "+" if @offset>0
    throw_string << "#{@offset}" if @offset!=0
    return throw_string
  end
  
  private 
  
  # Rolls all the dice and adds the offset returning just the total sum.
  def simple_roll
    total = 0
    dice.each do |die|
      total+= die.roll
    end
    total += offset
    return total
  end
  
  # Rolls all the dice and adds the offset returning and +Array+ with detailed info.
  # The first element of the +Array+ is the total sum of the rolled Throw and the second
  # is another +Array+ containing the result of each one of therolled die of the Throw in
  # the same order as returned by +dice+ (it may be different from the one used for 
  # initialize the Throw as it is ordered).
  def detailed_roll
    results = Array.new
    total = 0
    dice.each do |die|
      roll = die.roll
      total+= roll
      results << roll
    end
    total += offset
    detailed_throw = Array.new
    detailed_throw[0] = total
    detailed_throw[1] = results
    return detailed_throw
  end
end
