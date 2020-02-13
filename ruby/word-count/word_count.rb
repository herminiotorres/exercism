class Phrase
  def initialize(phrase = nil)
    @phrase_array = strip_phrase(phrase)
    @word_counter = {}
  end

  def word_count
    counter
    @word_counter
  end

  private

  def strip_phrase(phrase)
    return [] if phrase.nil?
    phrase
      .gsub(/([^a-zA-Z0-9 '])/i,' ')
      .gsub(/["']([^"' ]+)["']/, '\1')
      .downcase
      .split
  end

  def counter
    @phrase_array.each do |word|
      if @word_counter.has_key?(word)
        @word_counter[word] += 1
      else
        @word_counter.merge!({ word => 1 })
      end
    end
  end
end
