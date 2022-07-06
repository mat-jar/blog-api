RSpec.shared_context "create_10_flashcard_sets", :shared_context => :metadata do
  let!(:new_flashcards) { FactoryBot.build_list(:flashcard, 10) }

  before do
    for new_flashcard in new_flashcards do
    post '/api/v1/flashcard_sets', params:
                      { flashcard: {
                        front_text: new_flashcard.front_text,
                        back_text: new_flashcard.back_text
                      } }
  end
end
end
