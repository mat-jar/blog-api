
class AnalyseAnswerTime


  def self.get_average_by_user(user_id)
    average_answer_time = User.find(user_id).answer_times.average(:time_millisecond).to_i
  end

  def self.get_average_by_flashcard_set(flashcard_set_id)
    average_answer_time = FlashcardSet.find(flashcard_set_id).answer_times.average(:time_millisecond).to_i
  end

  def self.get_average_by_word(word)
    raise TypeError.new ("a word must be a String type") if !word.is_a? String
    average_answer_time = AnswerTime.joins(:flashcard).where("front_text = ? or back_text = ?", word, word).average(:time_millisecond).to_i
  end

  def self.get_average_by_learning_session(learning_session_id)
    average_answer_time = LearningSession.find(learning_session_id).answer_times.average(:time_millisecond).to_i
  end
end
