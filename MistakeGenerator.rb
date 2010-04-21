#/usr/bin/ruby
require File.dirname(__FILE__) + '/spellchecker.rb'

class MistakeGenerator
   def newMistake
     @spellChecker = SpellChecker.new
     goodWords = @spellChecker.store
     choice = String.new(@spellChecker.store.sort[(goodWords.size * rand).ceil][0])
     puts "going to mess this one up : " << choice
     vowels = ['a', 'e', 'i', 'o', 'u']
     choice.each_char{ |char|
       mistakeType = (3*rand).ceil
       case mistakeType
         when 1
           choice.insert(choice.index(char), char + char) if !choice.index(char).nil?
           #duplicate a letter, insert
         when 2
           vIdx = ((rand*5).ceil) -1
           vowel = vowels[vIdx]
           choice.gsub!(char, vowel) unless vowels.index(char).nil?
           #replace it with a vowel, if possible
         when 3
           choice.gsub!(char, char.upcase)     
           #uppercase
       end
     }
     choice
   end
   def spellChecker(mistake)
      @spellChecker.respond(mistake)
   end
end

mGen = MistakeGenerator.new
mistake = mGen.newMistake
puts "well here's a mistake " << mistake
puts "but the cleaner says it should be : " << mGen.spellChecker(mistake)