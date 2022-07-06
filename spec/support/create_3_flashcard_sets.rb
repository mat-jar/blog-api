RSpec.shared_context "create_3_flashcard_sets", :shared_context => :metadata do
  let!(:new_flashcard_sets) { FactoryBot.build_list(:flashcard_set, 3) }

  before do
    for new_flashcard_set in new_flashcard_sets do
    post '/api/v1/flashcard_sets', params:
                      { flashcard_set: {
                        title: new_flashcard_set.title,
                        description: new_flashcard_set.description,
                        category: new_flashcard_set.category
                      } }
  end
end
end
