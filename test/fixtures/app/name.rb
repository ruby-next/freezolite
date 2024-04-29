class Name
  attr_reader :name

  NAMES = %w[Alice Bob Charles Diana]

  def initialize(name = NAMES.sample)
    @name = name
  end

  def +(other)
    @name << " " << other
  end
end
