module Tools
  class CheckRoll

    attr_accessor :throw, :threshold, :rolling_chances, :greater_than_threshold, :equal_than_threshold
    attr_reader :result
    def initialize throw, threshold, rolling_chances=1, greater_than_threshold=true, equal_than_threshold=true
      @throw = throw
      @threshold = threshold
      @rolling_chances = rolling_chances
      @greater_than_threshold = greater_than_threshold
      @equal_than_threshold = equal_than_threshold
    end

    # Rolls the Throw as many times as rolling chances are set.If has already
    # been rolled just returns the last result.
    # Returns the result as an +Array+ with the format [true/false, simple_best_rolled].
    # The first element of the array illustrates whether the check was successful or not.
    # The second element is the best rolled throw as a simple Throw result, a +Fixnum+.
    # For a more detailed result (with a detailed Throw result), use +detailed_result+.
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

    # Forces a new roll by deleting the old result.
    def reroll
      @result = nil
      roll
    end

    # Returns whether the check was successful or not. It rolls the check if not done before.
    def is_successful?
      roll if @result.blank?
      return @result[0]
    end

    # Returns the result as an +Array+ with the format [true/false, simple_best_rolled].
    # The first element of the array illustrates whether the check was successful or not.
    # The second element is the best rolled throw as a simple Throw result, a +Fixnum+.
    # For a more detailed result (with a detailed Throw result), use +detailed_result+.
    # It rolls the check if not done before.
    def result
      roll if @result.blank?
      [@result[0],@result[1][0]]
    end

    # Returns the result as an +Array+ with the format [true/false, detailed_best_rolled].
    # The first element of the array illustrates whether the check was successful or not.
    # The second element is the best rolled throw as a detailed Throw result, please
    # refer to +Tools::Throw.roll+ for more info on detailed Throw.
    # It rolls the check if not done before.
    def detailed_result
      roll if @result.blank?
      @result
    end

    # Returns the CheckRoll as a string. Example "2D4,1D6,1D20+3 must be greater or equal to 20."
    def to_s
      string = "#{@throw.to_s} #{I18n.t('rpg_tools.check_roll.must_be')} #{comparatives_text} #{@threshold}."
      if @result
        string << " #{I18n.t('rpg_tools.check_roll.already_checked')}"
        string << " #{@result[0] ? I18n.t('rpg_tools.check_roll.success') : I18n.t('rpg_tools.check_roll.failure')}"
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
        return I18n.t 'rpg_tools.check_roll.greater_and_equal'
      elsif gtt and !ett
        return I18n.t 'rpg_tools.check_roll.greater'
      elsif !gtt and !ett
        return I18n.t 'rpg_tools.check_roll.less'
      elsif !gtt and ett
        return I18n.t 'rpg_tools.check_roll.less_and_equal'
      end
    end
  end
end