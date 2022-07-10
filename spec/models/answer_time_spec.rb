require "rails_helper"

RSpec.describe AnswerTime, type: :model do
  describe 'validate time_millisecond' do
    let!(:new_user) { FactoryBot.create(:user) }
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }
    let!(:new_learning_session) { LearningSession.create(flashcard_set_id: new_flashcard_set.id, user_id: new_user.id) }

    subject { AnswerTime.new( learning_session_id: new_learning_session.id,
                              flashcard_id: new_flashcard.id,
                              round: 1,
                              time_millisecond: 10000)
                      }
    context 'given an integer value within range 0-10000' do

      it 'AnswerTime is valid' do
        expect(subject).to be_valid
      end
    end

    context 'given a float value' do

      it 'AnswerTime is not valid' do
        subject.time_millisecond = 1.1
        expect(subject).to_not be_valid
      end
    end

    context 'given an integer value higher than 10000' do

      it 'AnswerTime is not valid' do
        subject.time_millisecond = 10001
        expect(subject).to_not be_valid
      end
    end

    context 'given a negative integer value' do

      it 'AnswerTime is not valid' do
        subject.time_millisecond = -1
        expect(subject).to_not be_valid
      end
    end

  end
end
