require "rails_helper"

RSpec.describe AnalyseAnswerTime do

    let!(:new_user) { FactoryBot.create(:user) }
    let!(:new_flashcard_set) { FactoryBot.create(:flashcard_set, user_id: new_user.id) }
    let!(:new_flashcard) { FactoryBot.create(:flashcard, flashcard_set_id: new_flashcard_set.id) }
    let!(:new_learning_session) { LearningSession.create(learnable: new_flashcard_set, user_id: new_user.id) }
    let!(:new_answer_time1) { FactoryBot.create(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id, time_millisecond: 1000) }
    let!(:new_answer_time2) { FactoryBot.create(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id, time_millisecond: 3000) }
    let!(:new_answer_time3) { FactoryBot.create(:answer_time, flashcard_id: new_flashcard.id, learning_session_id: new_learning_session.id, time_millisecond: 8000) }

    describe '#get_average_by_user' do
      context 'given a user_id' do

        it 'does NOT raise error' do
          expect{AnalyseAnswerTime.get_average_by_user(new_user.id)}.not_to raise_error
        end

        it 'returns the average_answer_time' do
          expect(AnalyseAnswerTime.get_average_by_user(new_user.id)).to eq(4000)
        end
      end
    end

    describe '#get_average_by_flashcard_set' do
      context 'given a flashcard_set_id' do

        it 'returns the average_answer_time' do
          expect(AnalyseAnswerTime.get_average_by_flashcard_set(new_flashcard_set.id)).to eq(4000)
        end
      end
    end

    describe '#get_average_by_word' do
      context 'given a word and front_text' do

        it 'returns the average_answer_time' do
          new_flashcard.update!(front_text: "koza")
          expect(AnalyseAnswerTime.get_average_by_word("koza")).to eq(4000)
        end
      end
    end

    describe '#get_average_by_word' do
      context 'given a word and back_text' do

        it 'returns the average_answer_time' do
          new_flashcard.update!(back_text: "koza")
          expect(AnalyseAnswerTime.get_average_by_word("koza")).to eq(4000)
        end
      end
    end

    describe '#get_average_by_learning_session' do
      context 'given a learning_session_id' do

        it 'returns the average_answer_time' do
          expect(AnalyseAnswerTime.get_average_by_learning_session(new_learning_session.id)).to eq(4000)
        end
      end
    end
end
