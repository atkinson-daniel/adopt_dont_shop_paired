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

  def pets_applied(application, params)
    params.each do |key, value|
      if value == "applied"
        pet = @contents.find { |pet| pet['id'] == key.to_i }
        PetApplication.info(application, pet)
        @contents.delete(pet)
      end
    end
  end

  def delete_pet(pet_id)
    pet = @contents.find { |pet| pet["id"] == pet_id.to_i }
    @contents.delete(pet)
  end

  def contains?(pet_id)
    contents.any? { |pet| pet["id"] == pet_id }
  end
end
