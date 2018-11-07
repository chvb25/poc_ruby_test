require 'securerandom'
module Complement

  CHARSET = Array('a'..'z')
  #@!method generate random text
  # @param len : length of text
  def randomText (len, capitalize = false)
    capitalize ?  Array.new(len){CHARSET.sample}.join.capitalize : Array.new(len){CHARSET.sample}.join
  end


end