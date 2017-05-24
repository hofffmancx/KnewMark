namespace :dev do

  task :fake => :environment do
    # users = []
    # 10.times do
    #   users << User.create!( :email => Faker::Internet.email, :password => "12345678")
    # end

    admin = User.create( :email => "admin@example.com", :password => "111111", :password_confirmation => "111111", :is_admin => true )

    50.times do |i|
      knowledges = Knowledge.create!( :title => Faker::Book.title, :description => Faker::Lorem.paragraph, :status => "published" )

    end
  end

end
