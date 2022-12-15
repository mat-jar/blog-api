require "rails_helper"

RSpec.describe UserSentenceSet, type: :model do
  describe '#slug' do
    context 'given a user sentence set that exists in the database' do
      let!(:new_user) { FactoryBot.create(:user) }
      let!(:new_user_sentence_set) { FactoryBot.create(:user_sentence_set, user_id: new_user.id) }

      it 'returns the ID number join with the title' do
        slug = "#{new_user_sentence_set.id}-#{new_user_sentence_set.title.parameterize}"
        expect(new_user_sentence_set.slug).to eq(slug)
      end
    end

    context 'given a user sentence set that does NOT exist in the database' do
      let!(:new_user_sentence_set) { FactoryBot.build(:user_sentence_set)}
      it 'returns nil' do

        expect(new_user_sentence_set.slug).to be_nil
      end
    end
  end
end
