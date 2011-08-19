require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Tools::Die do
  
  before do
    @die = Tools::Die.new 20
  end  
  
  it "should create a Die" do
    assert @die
  end
  
  it "should roll a Die once" do
    assert @die.roll
  end  
  
  it "should roll a Die many times" do
    results = @die.roll 30
    assert results
    results.each do |result|
      assert result
    end
  end  
  
  it "should turn a Die into a String" do
    assert @die.to_s.eql? "D20"
  end  
  
end
