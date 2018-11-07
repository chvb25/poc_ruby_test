require_relative 'complement'

class Contact
  include Complement

  NUMBERS = Array('0'..'9')

  def initialize(arguments ={})
    @firstName = arguments[:firstName] == '' || arguments[:firstName].nil? ? randomText(rand(3..9), true ) : arguments[:firstName]
    @middleName = arguments[:middleName] == '' || arguments[:middleName].nil?  ? randomText(rand(3..9), true ) : arguments[:middleName]
    @lastName = arguments[:lastName] == '' || arguments[:lastName].nil?  ? randomText(rand(3..9), true ) : arguments[:lastName]
    @prefix = arguments[:prefix] == '' || arguments[:prefix].nil?  ? randomText(rand(0..5) ) : arguments[:prefix]
    @sufix = arguments[:sufix] == '' || arguments[:sufix].nil?  ? randomText(rand(0..3) ) : arguments[:sufix]
    @phones =  arguments[:phones].nil? ? generate_phones(rand(1..5) ) : arguments[:phones]
    @emails = arguments[:emails].nil? ? generate_emails(rand(1..5)) : arguments[:emails]
  end

  attr_accessor :firstName
  attr_accessor :middleName
  attr_accessor :lastName
  attr_accessor :phones
  attr_accessor :emails
  attr_accessor :prefix
  attr_accessor :sufix

  def generate_phones(len)
    Array.new(len){
      Array.new(8) { NUMBERS.sample }.join
    }
  end

  def generate_emails(len)
    Array.new(len){
      randomText(rand(5..15)) << '@demo.com'
    }
  end
end