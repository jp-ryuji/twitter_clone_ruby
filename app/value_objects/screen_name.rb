# frozen_string_literal: true

require_relative 'value_object'

class ScreenName < ValueObject
  SCREEN_NAME_REGEXP = /\A[0-9a-zA-Z_]{1,15}\z/i

  def initialize(screen_name)
    super()
    raise ArgumentError, 'Screen name cannot be nil' if screen_name.nil?
    raise ArgumentError, 'Screen name cannot be blank' if screen_name.strip.empty?
    raise ArgumentError, 'Invalid screen name format' unless screen_name.match?(SCREEN_NAME_REGEXP)

    @screen_name = screen_name.downcase
  end

  def to_s
    @screen_name
  end

  def ==(other)
    return false unless other.is_a?(ScreenName)

    @screen_name == other.screen_name
  end

  protected

  attr_reader :screen_name
end
