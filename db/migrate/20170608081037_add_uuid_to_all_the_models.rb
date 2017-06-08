class AddUuidToAllTheModels < ActiveRecord::Migration[5.0]
  def change
     add_column :knowledges, :friendly_id, :string
     add_index :knowledges, :friendly_id, :unique => true
     add_column :questions, :friendly_id, :string
     add_index :questions, :friendly_id, :unique => true
     add_column :anwsers, :friendly_id, :string
     add_index :anwsers, :friendly_id, :unique => true
     add_column :comments, :friendly_id, :string
     add_index :comments, :friendly_id, :unique => true
     add_column :discussions, :friendly_id, :string
     add_index :discussions, :friendly_id, :unique => true
     add_column :reviews, :friendly_id, :string
     add_index :reviews, :friendly_id, :unique => true
     add_column :users, :friendly_id, :string
     add_index :users, :friendly_id, :unique => true


     Knowledge.find_each do |e|
       e.update( :friendly_id => SecureRandom.uuid )
     end
     Question.find_each do |e|
       e.update( :friendly_id => SecureRandom.uuid )
     end
     Anwser.find_each do |e|
       e.update( :friendly_id => SecureRandom.uuid )
     end
     Comment.find_each do |e|
       e.update( :friendly_id => SecureRandom.uuid )
     end
     Discussion.find_each do |e|
       e.update( :friendly_id => SecureRandom.uuid )
     end
     Review.find_each do |e|
       e.update( :friendly_id => SecureRandom.uuid )
     end
     User.find_each do |e|
       e.update( :friendly_id => SecureRandom.uuid )
     end
  end
end
