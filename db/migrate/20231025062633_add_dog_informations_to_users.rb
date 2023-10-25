class AddDogInformationsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :dog_name, :string
    add_column :users, :dog_breed, :string
    add_column :users, :dog_age, :string
  end
end
