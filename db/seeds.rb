# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#Article.create(title: "Schedule", body: "meetings: IT, Accounts, HR")
#Article.create(title: "Visit", body: "children's home: perform duties")
#FlashcardSet.create(title: "Animals", description: "A1 animals for kids", category: "A1", user: User.find(1))

User.create(email: "test@example.com", password: "test@example.com")
#User.create(email: "test1@example.com", password: "test1@example.com")
#User.create(email: "test2@example.com", password: "test2@example.com")


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
    },
    {
      front_text: 'kot',
      back_text: 'cat'
    },
    {
      front_text: 'pies',
      back_text: 'dog'
    },
    {
      front_text: 'kaczka',
      back_text: 'duck'
    },
    {
      front_text: 'gęś',
      back_text: 'goose'
    },
    {
      front_text: 'krowa',
      back_text: 'cow'
    },
    {
      front_text: 'byk',
      back_text: 'bull'
    },
    {
      front_text: 'chomik',
      back_text: 'hamster'
    },
    {
      front_text: 'mrówka',
      back_text: 'ant'
    },
    {
      front_text: 'pszczoła',
      back_text: 'bee'
    },
    {
      front_text: 'osa',
      back_text: 'wasp'
    },
    {
      front_text: 'wąż',
      back_text: 'snake'
    },
    {
      front_text: 'królik',
      back_text: 'rabbit'
    },
    {
      front_text: 'zając',
      back_text: 'hare'
    },
    {
      front_text: 'motyl',
      back_text: 'butterfly'
    },
    {
      front_text: 'mucha',
      back_text: 'fly'
    },
    {
      front_text: 'jeleń',
      back_text: 'deer'
    },
    {
      front_text: 'niedźwiedź',
      back_text: 'bear'
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
    },
    {
      front_text: 'jabłko',
      back_text: 'apple'
    },
    {
      front_text: 'banan',
      back_text: 'banana'
    },
    {
      front_text: 'mango',
      back_text: 'mango'
    },
    {
      front_text: 'pomarańcza',
      back_text: 'oranage'
    },
    {
      front_text: 'cytryna',
      back_text: 'lemon'
    },
    {
      front_text: 'winogrona',
      back_text: 'grapes'
    },
    {
      front_text: 'wiśnia',
      back_text: 'cherry'
    },
    {
      front_text: 'ananas',
      back_text: 'pineapple'
    },
    {
      front_text: 'gruszka',
      back_text: 'pear'
    },
    {
      front_text: 'brzoskwinia',
      back_text: 'peach'
    },
    {
      front_text: 'śliwka',
      back_text: 'plum'
    },
    {
      front_text: 'arbuz',
      back_text: 'watermelon'
    },
    {
      front_text: 'kokos',
      back_text: 'coconut'
    },
    {
      front_text: 'agrest',
      back_text: 'gooseberry'
    },
    {
      front_text: 'kiwi',
      back_text: 'kiwi fruit'
    },
    {
      front_text: 'mandarynka',
      back_text: 'tengerine'
    },
    {
      front_text: 'borówka',
      back_text: 'blueberry'
    },
    {
      front_text: 'awokado',
      back_text: 'avocado'
    }
])
FlashcardSet.create(title: "Colours", description: "A1 colour names for kids", category: "A1", user: User.find(1),
  flashcards_attributes: [
    {
      front_text: 'zielony',
      back_text: 'green'
    },
    {
      front_text: 'czarny',
      back_text: 'black'
    },
    {
      front_text: 'zółty',
      back_text: 'yellow'
    },
    {
      front_text: 'pomaranczowy',
      back_text: 'orange'
    },
    {
      front_text: 'niebieski',
      back_text: 'blue'
    },
    {
      front_text: 'biały',
      back_text: 'white'
    },
    {
      front_text: 'czerwony',
      back_text: 'black'
    },
    {
      front_text: 'rózowy',
      back_text: 'pink'
    },
    {
      front_text: 'szary',
      back_text: 'grey'
    },
    {
      front_text: 'złoty',
      back_text: 'golden'
    },
    {
      front_text: 'srebrny',
      back_text: 'silver'
    },
    {
      front_text: 'fioletowy',
      back_text: 'purple'
    },
    {
      front_text: 'granatowy',
      back_text: 'navy blue'
    },
    {
      front_text: 'brązowy',
      back_text: 'brown'
    },
    {
      front_text: 'przezroczysty',
      back_text: 'transparent'
    },
    {
      front_text: 'bezbarwny',
      back_text: 'colorless'
    },
    {
      front_text: 'wielokolorowy',
      back_text: 'colourful'
    },
    {
      front_text: 'ciemny',
      back_text: 'dark'
    },
    {
      front_text: 'jasny',
      back_text: 'light'
    },
    {
      front_text: 'blady',
      back_text: 'pale'
    },
    {
      front_text: 'jaskrawy',
      back_text: 'glowing'
    }
  ])
  FlashcardSet.create(title: "Weather", description: "A1 weather words for kids", category: "A1", user: User.find(1),
  flashcards_attributes: [
    {
      front_text: 'warunki pogodowe',
      back_text: 'weather conditions'
    },
    {
      front_text: 'prognoza pogody',
      back_text: 'weather forcast'
    },
    {
      front_text: 'słonecznie',
      back_text: 'sunny'
    },
    {
      front_text: 'pochmurno',
      back_text: 'cloudly'
    },
    {
      front_text: 'chmura',
      back_text: 'cloud'
    },
    {
      front_text: 'deszcz',
      back_text: 'rain'
    },
    {
      front_text: 'grad',
      back_text: 'hail'
    },
    {
      front_text: 'wiatr',
      back_text: 'wind'
    },
    {
      front_text: 'wietrznie',
      back_text: 'windy'
    },
    {
      front_text: 'mgła',
      back_text: 'fog'
    },
    {
      front_text: 'burza',
      back_text: 'storm'
    },
    {
      front_text: 'sucho',
      back_text: 'dry'
    },
    {
      front_text: 'mokro',
      back_text: 'wet'
    },
    {
      front_text: 'ciepło',
      back_text: 'warm'
    },
    {
      front_text: 'zimo',
      back_text: 'cold'
    },
    {
      front_text: 'gorąco',
      back_text: 'hot'
    },
    {
      front_text: 'śnieg',
      back_text: 'snow'
    },
    {
      front_text: 'mróz',
      back_text: 'frost'
    },
    {
      front_text: 'mgliście',
      back_text: 'foggy'
    }

  ])
  FlashcardSet.create(title: "Body parts",description: "A1 body parts for kids", category: "A1", user: User.find(1),
  flashcards_attributes: [
    {
      front_text: 'głowa',
      back_text: 'head'
    },
    {
      front_text: 'ręka',
      back_text: 'arm'
    },
    {
      front_text: 'noga',
      back_text: 'leg'
    },
    {
      front_text: 'palec u dłoni',
      back_text: 'finger'
    },
    {
      front_text: 'szyja',
      back_text: 'neck'
    },
    {
      front_text: 'nos',
      back_text: 'nose'
    },
    {
      front_text: 'usta',
      back_text: 'mouth'
    },
    {
      front_text: 'oko',
      back_text: 'eye'
    },
    {
      front_text: 'włosy',
      back_text: 'hair'
    },
    {
      front_text: 'stopa',
      back_text: 'foot'
    },
    {
      front_text: 'dłoń',
      back_text: 'hand'
    },
    {
      front_text: 'ucho',
      back_text: 'ear'
    },
    {
      front_text: 'gardło',
      back_text: 'throat'
    },
    {
      front_text: 'brzuch',
      back_text: 'stomach'
    },
    {
      front_text: 'plecy',
      back_text: 'back'
    },
    {
      front_text: 'klatka piersiowa',
      back_text: 'chest'
    },
    {
      front_text: 'kolano',
      back_text: 'knee'
    },
    {
      front_text: 'łydka',
      back_text: 'calf'
    },
    {
      front_text:'kręgosłup',
      back_text: 'spine'
    }
  ])
  FlashcardSet.create(title: "Jobs", description: "A1 job names for kids", category: "A1", user: User.find(1),
  flashcards_attributes:[
    {
      front_text: 'policjant',
      back_text: 'police oficer'
    },
    {
      front_text: 'lekarz',
      back_text: 'doctor'
    },
    {
      front_text: 'nauczyciel',
      back_text: 'teacher'
    },
    {
      front_text: 'prawnik',
      back_text: 'lawyer'
    },
    {
      front_text: 'pielęgniarka/pielegniarz',
      back_text: 'nurse'
    },
    {
      front_text: 'sprzedawca',
      back_text: 'shop assistant'
    },
    {
      front_text: 'inżynier',
      back_text: 'engineer'
    },
    {
      front_text: 'hydraulik',
      back_text: 'plumber'
    },
    {
      front_text: 'stolarz',
      back_text: 'carpenter'
    },
    {
      front_text: 'fryzjer/fryzerka',
      back_text: 'hairdresser'
    },
    {
      front_text: 'księgowy',
      back_text: 'accountant'
    },
    {
      front_text: 'ogrodnik',
      back_text: 'gardener'
    },
    {
      front_text: 'naukowiec',
      back_text: 'scientist'
    },
    {
      front_text: 'strażak',
      back_text: 'firefighter'
    },
    {
      front_text: 'elektryk',
      back_text: 'electrician'
    },
    {
      front_text: 'żołnierz',
      back_text: 'solidier'
    },
    {
      front_text: 'muzyk',
      back_text: 'musician'
    },
    {
      front_text: 'aktor',
      back_text: 'actor'
    },
    {
      front_text: 'aktorka',
      back_text: 'actress'
    }
  ])
  FlashcardSet.create(title: "Nature", description: "A1 nature words for kids", category: "A1", user: User.find(1),
  flashcards_attributes: [
{
  front_text: 'roślina',
  back_text: 'plant'
},
{
  front_text: 'zwierzę',
  back_text: 'animal'
},
{
  front_text: 'las',
  back_text: 'forest'
},
{
  front_text: 'pustynia',
  back_text: 'desert'
},
{
  front_text: 'ocean',
  back_text: 'ocean'
},
{
  front_text: 'morze',
  back_text: 'sea'
},
{
  front_text: 'jezioro',
  back_text: 'lake'
},
{
  front_text: 'rzeka',
  back_text: 'river'
},
{
  front_text: 'góra',
  back_text: 'mountain'
},
{
  front_text: 'nizina',
  back_text: 'lowland'
},
{
  front_text: 'wzgórze',
  back_text: 'hill'
},
{
  front_text: 'drzewo',
  back_text: 'tree'
},
{
  front_text: 'krzak',
  back_text: 'bush'
},
{
  front_text: 'wyspa',
  back_text: 'island'
},
{
  front_text: 'skała',
  back_text: 'rock'
},
{
  front_text: 'niebo',
  back_text: 'sky'
},
{
  front_text: 'słonce',
  back_text: 'sun'
},
{
  front_text: 'księżyc',
  back_text: 'moon'
},
{
  front_text:'lodowiec',
  back_text: 'glacier'
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
