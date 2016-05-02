class Phone < ActiveRecord::Base

  belongs_to :phoneable, polymorphic: true
  
  validates :number, presence: true, numericality: true, length: { minimum: 7, maximum: 11}


  def format_number
    if number.length == 7
      "#{number.to_s[0..2]}-#{number.to_s[3..4]}-#{number.to_s[5..6]}"
    elsif number.length == 10
      "(#{number.to_s[0..2]}) #{number.to_s[3..5]}-#{number.to_s[6..7]}-#{number.to_s[8..9]}"
    elsif number.length == 11
      "#{number.to_s[0]} (#{number.to_s[1..3]}) #{number.to_s[4..6]}-#{number.to_s[7..8]}-#{number.to_s[9..10]}"
    else
      number
    end
  end
end
