class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def total_count
    @contents.count
  end

  def add_pet(pet)
    @contents << pet
  end

  def all_favorited_pets
    @contents
  end
end
