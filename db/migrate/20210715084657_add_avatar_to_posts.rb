class AddAvatarToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :avatars, :string
  end
end
