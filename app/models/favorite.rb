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

  def delete_pet(pet_id)
    pet = @contents.find { |pet| pet["id"] == pet_id.to_i }
    @contents.delete(pet)
  end

  def contains?(pet_id)
    contents.any? { |pet| pet["id"] == pet_id }
  end
end
