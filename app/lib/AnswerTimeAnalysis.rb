
class AnswerTimeAnalysis
  def get_user_average_answer_time(user_id)
  @average_answer_time = AnswerTime.average(:time_millisecond, :user_id => user_id )


end
