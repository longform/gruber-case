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
    
    def namecase
      small_words = ["'s", "'t", "aan", "aan 't", "aan de", "aan den", "aan der", "aan het", "al", "auf", "aus", "bij", "bij 't", "bij de", "bij den", "bij het", "boven d'", "d'", "da[s]?", "dalla", "de", "de die", "de die le", "de l'", "de la", "de las", "de le", "de van der", "del", "della", "den", "der", "des", "di", "do[s]?", "el", "het", "in", "in 't", "in de", "in den", "in der", "in het", "onder", "onder 't", "onder de", "onder den", "onder het", "op", "op 't", "op de", "op den", "op der", "op gen", "op het", "op ten", "over", "over 't", "over de", "over den", "over het", "saint", "st", "ste", "te", "ten", "ter", "tot", "uijt", "uijt 't", "uijt de", "uijt den", "uijt het", "uijt te de", "uijt ten", "uit", "uit 't", "uit de", "uit den", "uit het", "uit te de", "uit ten", "van 't", "van de", "van de l'", "van den", "van der", "van gen", "van het", "van la", "van ter", "van van de", "vander", "ver", "voor", "voor de", "voor den", "voor in 't"]
      small_re = small_words.join('|')
      s = self.split(" ").map { |word| word.split("-").map(&:capitalize).join("-") }.join(" ")
      s.gsub!(/'\w/io) { |w| w.upcase }
      s.gsub!(/\b(#{small_re})\b/io) { |w| w.downcase }
      s
    end
end