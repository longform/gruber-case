#!/bin/env ruby
# encoding: utf-8

class String
  def grubercase
    small_words = %w( a an and as at but by en for if in of on or the to v[.]? via vs[.]? )
    small_re = small_words.join('|')


    line = ""
    self.split(/( [:.;?!][ ] | (?:[ ]|^)["“] )/x).each do |s|
    
      s.gsub!(/ \b( [[:alpha:]] [[:lower:].'’]* )\b /x) do |w|
        # Skip words with inline dots, e.g. "del.icio.us" or "example.com"
        (w =~ / [[:alpha:]] [.] [[:alpha:]] /x) ? w : w.capitalize
      end #gsub!
    
      # Lowercase our list of small words:
      s.gsub!(/\b(#{small_re})\b/io) { |w| w.downcase }
    
      # If the first word in the title is a small word, then capitalize it:
      s.gsub!(/\A([[:punct:]]*)(#{small_re})\b/io) { |w| $1 + $2.capitalize }
    
      # If the last word in the title is a small word, then capitalize it:
      s.gsub!(/\b(#{small_re})([[:punct:]]*)\Z/io) { |w| $1.capitalize + $2 }
    
      # Append current substring to output
      line += s
    
    end #each
  
    # Special Cases:
    line.gsub!(/ V(s?)\. /, ' v\1. ')               # "v." and "vs."
    line.gsub!(/(['’])S\b/, '\1s')                  # 'S (otherwise you get "the SEC'S decision")
    line.gsub!(/\b(AT&T|Q&A)\b/i) { |w| w.upcase }  # "AT&T" and "Q&A", which get tripped up by
                                                  # self-contained small words "at" and "a"

    line
    end
end