require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')



describe Tools::CheckRoll do
  describe "basic funtionality" do
    before do
      @dice = [Tools::Die.new(20),Tools::Die.new(6),Tools::Die.new(20),Tools::Die.new(4),Tools::Die.new(20),
        Tools::Die.new(100),Tools::Die.new(4),Tools::Die.new(100)]
      @offset = 25
      @throw = Tools::Throw.new @dice,@offset
      @threshold = 20

      @check_roll = Tools::CheckRoll.new @throw, @threshold
    end

    it "should create a CheckRoll" do
      assert @check_roll
    end

    it "should roll a CheckRoll" do
      roll = @check_roll.roll
      assert roll
      assert roll[0]
      assert roll[1]
    end

    it "should reroll a CheckRoll" do
      roll = @check_roll.roll
      roll = @check_roll.reroll
      assert roll
      assert roll[0]
      assert roll[1]
    end    

    it "should roll a CheckRoll with several rolling chances" do
      @check_roll.rolling_chances = 10
      roll = @check_roll.roll
      assert roll
      assert roll[0]
      assert roll[1]
    end

    it "should reroll a CheckRoll with several rolling chance" do
      @check_roll.rolling_chances = 10
      roll = @check_roll.roll
      roll = @check_roll.reroll
      assert roll
      assert roll[0]
      assert roll[1]
    end    

    it "should check if a CheckRoll was succesful after rolled" do
      roll = @check_roll.roll
      assert @check_roll.is_successful?.is_a? TrueClass
    end

    it "should check if a CheckRoll was succesful and roll it if not rolled" do
      assert @check_roll.is_successful?.is_a? TrueClass
    end
  
    it "should turn a CheckRoll into a String" do
      string = "#{@throw.to_s} #{I18n.t('fuzion_rpg.tools.check_roll.must_be')} #{I18n.t('fuzion_rpg.tools.check_roll.greater_and_equal')} #{@check_roll.threshold}."
      assert @check_roll.to_s.eql? string
    end
  end

  it "should check a greater or equal to threshold" do
    @dice = [Tools::Die.new(1)]
    @offset = 19
    @throw = Tools::Throw.new @dice,@offset
    @threshold = 20
    @check_roll = Tools::CheckRoll.new @throw, @threshold, 1, true, true
    assert @check_roll.is_successful?
    @check_roll.threshold = 15
    @check_roll.reroll
    assert @check_roll.is_successful?    
  end

  it "should check a greater than threshold" do
    @dice = [Tools::Die.new(1)]
    @offset = 19
    @throw = Tools::Throw.new @dice,@offset
    @threshold = 20
    @check_roll = Tools::CheckRoll.new @throw, @threshold, 1, true, false
    assert !@check_roll.is_successful?
    @check_roll.threshold = 15
    @check_roll.reroll
    assert @check_roll.is_successful?    
  end

  it "should check a less than threshold" do
    @dice = [Tools::Die.new(1)]
    @offset = 19
    @throw = Tools::Throw.new @dice,@offset
    @threshold = 20
    @check_roll = Tools::CheckRoll.new @throw, @threshold, 1, false, false
    assert !@check_roll.is_successful?
    @check_roll.threshold = 25
    @check_roll.reroll
    assert @check_roll.is_successful?    
  end

  it "should check a less or equal to threshold" do
    @dice = [Tools::Die.new(1)]
    @offset = 19
    @throw = Tools::Throw.new @dice,@offset
    @threshold = 20
    @check_roll = Tools::CheckRoll.new @throw, @threshold, 1, false, true
    assert @check_roll.is_successful?
    @check_roll.threshold = 25
    @check_roll.reroll
    assert @check_roll.is_successful?    
  end

end
