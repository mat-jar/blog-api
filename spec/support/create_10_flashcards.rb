RSpec.shared_context "create_3_flashcard_sets", :shared_context => :metadata do
  let!(:my_flashcards) { FactoryBot.build_list(:flashcard, 10) }

  before do
    for my_flashcard in my_flashcards do
    post '/api/v1/flashcard_sets', params:
                      { flashcard: {
                        front_text: my_flashcard.front_text,
                        back_text: my_flashcard.back_text
                      } }
  end
end
end
