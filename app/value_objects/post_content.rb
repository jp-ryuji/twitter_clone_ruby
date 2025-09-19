# frozen_string_literal: true

require_relative 'value_object'

class PostContent < ValueObject
  MAX_LENGTH = 140

  def initialize(content)
    super()
    raise ArgumentError, 'Content cannot be nil' if content.nil?
    raise ArgumentError, 'Content cannot be blank' if content.strip.empty?
    raise ArgumentError, 'Content is too long' if content.length > MAX_LENGTH

    @content = content
  end

  def to_s
    @content
  end

  def ==(other)
    return false unless other.is_a?(PostContent)

    @content == other.content
  end

  protected

  attr_reader :content
end
