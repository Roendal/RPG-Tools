class Tools::CheckRoll

  attr_accessor :throw, :threshold, :rolling_chances, :greater_than_threshold, :equal_than_threshold
  attr_reader :result
  def initialize throw, threshold, rolling_chances=1, greater_than_threshold=true, equal_than_threshold=true
    @throw = throw
    @threshold = threshold
    @rolling_chances = rolling_chances
    @greater_than_threshold = greater_than_threshold
    @equal_than_threshold = equal_than_threshold
  end

  #[true/false,best_rolled]
  def roll
    return @result if @result
    best_rolled = 0
    @rolling_chances.times do
      rolled_throw = @throw.roll 1,true #Detailed throw
      best_rolled = rolled_throw if rolled_throw[0] > best_rolled[0]
    end
    @result = [compare(best_rolled[0], @threshold),best_rolled]    
    result
  end

  def reroll
    @result = nil
    roll
  end

  def is_successful?
    roll if @result.blank?
    return @result[0]
  end  
  
  def result
    [@result[0],@result[1][0]]
  end
  
  def detailed_result
    @result
  end

  def to_s
    string = "#{@throw.to_s} #{I18n.t('fuzion_rpg.tools.check_roll.must_be')} #{comparatives_text} #{@threshold}."
    if @result
      string << " #{I18n.t('fuzion_rpg.tools.check_roll.already_checked')}" 
      string << " #{@result[0] ? I18n.t('fuzion_rpg.tools.check_roll.success') : I18n.t('fuzion_rpg.tools.check_roll.failure')}"
      string << " (#{@result[1][0]})."
    end
    string
  end

  private

  def compare rolled_throw, threshold
    gtt = @greater_than_threshold
    ett = @equal_than_threshold
    if gtt and ett
    return rolled_throw >= threshold
    elsif gtt and !ett
    return rolled_throw > threshold
    elsif !gtt and !ett
    return rolled_throw < threshold
    elsif !gtt and ett
    return rolled_throw <= threshold
    end
  end
  
  def comparatives_text
    gtt = @greater_than_threshold
    ett = @equal_than_threshold
    if gtt and ett
    return I18n.t 'fuzion_rpg.tools.check_roll.greater_and_equal'
    elsif gtt and !ett
    return I18n.t 'fuzion_rpg.tools.check_roll.greater'
    elsif !gtt and !ett
    return I18n.t 'fuzion_rpg.tools.check_roll.less'
    elsif !gtt and ett
    return I18n.t 'fuzion_rpg.tools.check_roll.less_and_equal'
    end
  end
end