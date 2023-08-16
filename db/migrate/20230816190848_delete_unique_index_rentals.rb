class DeleteUniqueIndexRentals < ActiveRecord::Migration[7.0]
  def change
    remove_index :rentals, name: 'index_rentals_on_user_id_and_movie_id'
    add_index :rentals, %i[user_id movie_id], unique: false
  end
end
