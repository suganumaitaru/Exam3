class AddTopicToPicture < ActiveRecord::Migration
  def change
    add_column :topics, :pictures, :string
  end
end
