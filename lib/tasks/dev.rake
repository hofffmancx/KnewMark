namespace :dev do

  task :fake => :environment do
    users = []

    100.times do
      users << User.create( :email => Faker::Internet.email, :username => Faker::Internet.email, :password => "111111", :password_confirmation => "111111",)
    end

    admin = User.create( :email => "admin@example.com", :username => "小小鸟", :password => "111111", :password_confirmation => "111111", :role => 'admin' )

    categories = []
    5.times do |i|
      categories << Category.create( :title => Faker::Lorem.word )
    end

    knowledges = []
    100.times do |i|
      knowledges << Knowledge.create( :title => Faker::Book.title,
                                      :description => Faker::Lorem.paragraphs,
                                      :status => "published",
                                      :category_id => categories.sample.id,
                                      :user_id => users.sample.id )
    end

    reviews = []
    500.times do |i|
      reviews << Review.create( :title => Faker::Lorem.word,
                                 :content => Faker::Lorem.paragraph(50),
                                 :knowledge_id => knowledges.sample.id,
                                 :user_id => users.sample.id )
    end

    discussions = []
    500.times do |i|
      discussions << Discussion.create( :content => Faker::Lorem.sentence,
                                         :knowledge_id => knowledges.sample.id,
                                         :user_id => users.sample.id )
    end

    questions = []
    500.times do |i|
      questions << Question.create( :title => Faker::Lorem.sentence,
                                  
                                     :knowledge_id => knowledges.sample.id,
                                     :user_id => users.sample.id )
    end

    comments = []
    500.times do |i|
      comments << Comment.create( :content => Faker::Lorem.sentence,
                                         :review_id => reviews.sample.id,
                                         :user_id => users.sample.id )
    end

  end

end
