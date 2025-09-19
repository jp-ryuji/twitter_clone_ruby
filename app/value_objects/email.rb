# frozen_string_literal: true

require_relative 'value_object'

class Email < ValueObject
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i

  def initialize(email)
    super()
    raise ArgumentError, 'Email cannot be nil' if email.nil?
    raise ArgumentError, 'Email cannot be blank' if email.strip.empty?
    raise ArgumentError, 'Invalid email format' unless email.match?(EMAIL_REGEX)

    @email = email.downcase
  end

  def to_s
    @email
  end

  def ==(other)
    return false unless other.is_a?(Email)

    @email == other.email
  end

  protected

  attr_reader :email
end
