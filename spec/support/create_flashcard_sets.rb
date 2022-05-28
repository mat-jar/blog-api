RSpec.shared_context "create_flashcard_sets", :shared_context => :metadata do
  let!(:my_flashcard_set) { FactoryBot.build(:flashcard_set) }

  before do
    post '/api/v1/flashcard_sets', params:
                      { flashcard_set: {
                        title: my_flashcard_set.title,
                        description: my_flashcard_set.description,
                        category: my_flashcard_set.category
                      } }
    my_flashcard_set.id = json['id']
  end
end
