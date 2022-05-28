RSpec.shared_context "create_3_flashcard_sets", :shared_context => :metadata do
  let!(:my_flashcard_sets) { FactoryBot.build_list(:flashcard_set) }

  before do
    for my_flashcard_set in my_flashcard_sets do
    post '/api/v1/flashcard_sets', params:
                      { flashcard_set: {
                        title: my_flashcard_set.title,
                        description: my_flashcard_set.description,
                        category: my_flashcard_set.category
                      } }
  end
end
