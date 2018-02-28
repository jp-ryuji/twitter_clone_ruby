# frozen_string_literal: true

class Code
  CHARS_FOR_CODE = ([*('a'..'z'), *('A'..'Z'), *('0'..'9')] - %w[0 1 l o I O]).freeze
  # CHARS_FOR_CODE = ([*('A'..'Z'), *('0'..'9')] - %w[0 1 I O]).freeze

  def self.generate_random_string(length = 6)
    Array.new(length) { CHARS_FOR_CODE.sample }.join
  end

  def initialize(obj, attr_name = :code)
    @obj = obj
    @klass = obj.class
    @attr_name = attr_name
  end

  def assign_value
    @obj[@attr_name] = generate(10)
  end

  private

  def generate(number = 1)
    loop do
      codes = Array.new(number) { Code.generate_random_string }
      existing_codes = @klass.where(@attr_name => codes).pluck(@attr_name)
      codes -= existing_codes
      return codes.first if codes.present?
    end
  end
end
