# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Article.create(title: "Schedule", body: "meetings: IT, Accounts, HR")
Article.create(title: "Visit", body: "children's home: perform duties")
#FlashcardSet.create(title: "Animals", description: "A1 animals for kids", category: "A1", user: User.find(1))


FlashcardSet.create(title: "Animals", description: "A1 animals for kids", category: "A1", user: User.find(1),
  flashcards_attributes: [
    {
        front_text: 'koza',
        back_text: 'goat'
    },
    {
      front_text: 'lis',
      back_text: 'fox'
    },
    {
      front_text: 'dziobak',
      back_text: 'platypus'
    }

])
FlashcardSet.create(title: "Fruits", description: "A1 fruit names for kids", category: "A1", user: User.find(1),
  flashcards_attributes: [
    {
        front_text: 'truskawka',
        back_text: 'strawberry'
    },
    {
      front_text: 'malina',
      back_text: 'raspberry'
    },
    {
      front_text: 'jagoda',
      back_text: 'blueberry'
    }
])

=begin
Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')].sort.each do |seed|
  load seed
end

Dir[File.join(Rails.root, 'db', 'seeds/folder_name_here', '*.rb')].sort.each do |seed|
  load seed
end

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

=end
