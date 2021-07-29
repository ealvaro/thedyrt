# frozen_string_literal: true

# Monkeypatch to Fixnum to be able to convert integers to Roman numerals
class Integer
  ROMAN_NUMS = {
    'M' => 1000,
    'CM' => 900, 'D' => 500, 'CD' => 400, 'C' => 100,
    'XC' => 90,  'L' => 50,  'XL' => 40,  'X' => 10,
    'IX' => 9,   'V' => 5,   'IV' => 4,   'I' => 1
  }.freeze

  def roman
    num = self
    ROMAN_NUMS.map do |ltr, val|
      amt, num = num.divmod(val)
      ltr * amt
    end.join
  end
end
