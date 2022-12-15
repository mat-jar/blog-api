require "rails_helper"

RSpec.describe FlashcardSet, type: :model do
  describe '#slug' do
    context 'given a flashcard set that exists in the database' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }

      it 'returns the ID number join with the title' do
        slug = "#{new_flashcard_set.id}-#{new_flashcard_set.title.parameterize}"
        expect(new_flashcard_set.slug).to eq(slug)
      end
    end

    context 'given a flashcard set that does NOT exist in the database' do
      let!(:new_flashcard_set) { FactoryBot.build(:flashcard_set)}
      it 'returns nil' do

        expect(new_flashcard_set.slug).to be_nil
      end
    end
  end
end
