
class AnalyseAnswerTime

  def self.get_user_average_answer_time(user_id)
    average_answer_time = User.find(user_id).answer_times.average(:time_millisecond).to_i
  end

  def self.get_flashcard_set_average_answer_time(flashcard_set_id)
    average_answer_time = FlashcardSet.find(flashcard_set_id).answer_times.average(:time_millisecond).to_i
  end

  def self.get_word_average_answer_time(word)
    average_answer_time = Flashcard.where("front_text = ? or back_text = ?", word, word).joins(:answer_times).average(:time_millisecond).to_i
  end

  def self.get_learning_session_average_answer_time(learning_session_id)
    average_answer_time = LearningSession.find(learning_session_id).answer_times.average(:time_millisecond).to_i
  end
end
