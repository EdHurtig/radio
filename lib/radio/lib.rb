class Array
  def deep_dup
    map {|x| x.deep_dup}
  end
end

class Object
  def deep_dup
    dup
  end
end

class Numeric
  # We need this because number.dup throws an exception
  # We also need the same definition for Symbol, TrueClass and FalseClass
  def deep_dup
    self
  end
end
