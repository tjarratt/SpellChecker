require 'rubygems'
require File.dirname(__FILE__) + '/../spellchecker.rb'

describe SpellChecker do
  before(:each) do
    @checker = SpellChecker.new
  end
  
  it 'should read in a dict' do
    @checker.store.size.should >= 1
  end     
  
  it 'should respond to input' do
    @checker.respond("sheep").should == "sheep"
  end
  
  it 'should correct mixedcase' do
    @checker.respond('SHeeP').should == 'sheep'
  end
  
  it 'should try to remove repeated characters and match' do
     @checker.respond('jjooob').should == 'job'
  end
  
  it 'should not find any suggestions for garbage' do
    @checker.respond('KKCKKJEH').should == 'NO SUGGESTION'
  end                                         
  
  it 'should match misplaced vowels' do
    @checker.respond('weke').should == 'wake'
  end
  
  it 'should look for more than one type of error' do
    @checker.respond('CUNsperrICY').should == 'conspiracy'
  end
  
  it 'should understand words that are capitalized in the dictionary as well' do
    @checker.respond('Loatuko').should == 'Loatuko'
  end#from MistakeGenerator.rb
  
end