# frozen_string_literal: true

class ValueObject
  def ==(other)
    return false unless other.instance_of?(self.class)

    instance_variables.all? do |var|
      instance_variable_get(var) == other.instance_variable_get(var)
    end
  end

  alias eql? ==

  def hash
    instance_variables.map { |var| instance_variable_get(var) }.hash
  end
end
