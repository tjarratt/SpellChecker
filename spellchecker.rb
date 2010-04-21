class String
   def vowels
     scan(/[aeiou]/i).uniq
   end
end#small string class extension to get to the vowels quickly

class SpellChecker 
  def initialize 
     @dict = Hash.new
     text = File.open('/usr/share/dict/words') do |f|
       f.read
     end  
     text.split(/\s/).each { |line|    
       @dict[line] = 1
     }
     #really only doing this to circumvent the spec tests
     listen if $0 == "spellchecker.rb"
     
  end
  
  def store
    @dict
  end #helper method for spec     
  
  def listen
    puts "Please type a word to begin. Type 'QUIT' (or ctrl+c) to finish."
    io = nil
    while io != 'QUIT' 
       io = gets
       result = respond(io.strip)#extra new line character              
       puts result
    end
  end #main
  
  def respond(word)  
     #find the first correct response
     if @dict.has_key?(word)
       return word
     end#didn't expect uppercase words in /usr/share/dict/words
     
     permutation = word.downcase()
     if @dict.has_key?(permutation.to_s)
       return permutation
     end                   
     
     permutation = word.downcase().squeeze()
     if @dict.has_key?(permutation)
       return permutation
     end          
     
     result = checkSubString(word, -1)
     if result.class == String and @dict.has_key?(result)
       return result
     end
     return 'NO SUGGESTION'
  end        
  
  def check_valid(word)
    #compare to dict
    good = nil
    if @dict.has_key?(word)
      good = word
    end
    if @dict.has_key?(word.squeeze)
      good = word.squeeze
    end
    return good
  end
  
  def checkSubString(word, index)
    word = word.downcase()
    word.vowels.each{ |wv|
      idx = word.index(wv, index + 1)
      while not idx.nil? and idx < word.size - 1 do
        ['a', 'e', 'i', 'o', 'u'].each{ |v|
          permutation = word 
          permutation[idx] = '' if v!= wv         
          permutation.insert(idx, v) if v != wv
          result = check_valid(permutation)
          if not result.nil?
            return result
          end
          result = checkSubString(permutation, idx + 1)
          if ! result.nil?
            return result
          end
        }
        idx = word.index(wv, idx + 1)
      end
    }
    return nil
  end
  
end                 

@sc = SpellChecker.new