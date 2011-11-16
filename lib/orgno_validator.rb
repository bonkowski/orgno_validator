# encoding: UTF-8

class OrgnoValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless OrgnoValidator.valid_orgno?(value)
      record.errors.add(attribute, options[:message] || :invalid)
    end
  end

  private

  BASE_MOD_11_WEIGHTS = [2, 3, 4, 5, 6, 7]
  ORGNO_LENGTH = 9

  class << self
    attr_accessor :orgno_mod_11_weights
  end

  def self.mod_11_weights_generator(length)
    weights = []
    (0..length-2).each do |index|
      base_index = index % BASE_MOD_11_WEIGHTS.length
      weights << BASE_MOD_11_WEIGHTS[base_index]
    end
    weights.reverse!
  end

  @orgno_mod_11_weights = OrgnoValidator.mod_11_weights_generator(ORGNO_LENGTH)

  def self.valid_orgno?(orgno)
    return false if !orgno || orgno.to_s.length != ORGNO_LENGTH

    orgno_digits = orgno.to_s.each_char.map { |d| d.to_i }
    sum = 0

    (0..orgno_digits.length-2).each do |i|
      sum += orgno_digits[i].to_i * @orgno_mod_11_weights[i]
    end

    remainder = sum % 11
    control_digit = remainder == 0 ? 0 : 11 - remainder

    return false if control_digit == 10
    return control_digit == orgno_digits.last
  end
end
