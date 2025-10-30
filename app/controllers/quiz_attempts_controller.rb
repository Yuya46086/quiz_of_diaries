class QuizAttemptsController < ApplicationController
  before_action :authenticate_user!

  def new
    user_post_ids = current_user.posts.pluck(:id)
    
    @daily_quiz = DailyQuiz
                    .joins(:post)
                    .where(post_id: user_post_ids)
                    .where.not(id: current_user.quiz_attempts.pluck(:daily_quiz_id))
                    .where.not(posts: { post_date: nil })
                    .order('RAND()')
                    .first
    
    if @daily_quiz.nil?
      redirect_to root_path, alert: "挑戦できるクイズがありません。日記をもっと投稿しましょう！"
      return
    end

    @quiz_attempt = current_user.quiz_attempts.build(daily_quiz: @daily_quiz)
  end

  def create
    @quiz_attempt = current_user.quiz_attempts.build(quiz_attempt_params)

    daily_quiz = @quiz_attempt.daily_quiz
    correct_answer = daily_quiz.correct_answer

    is_correct = normalize_answer(@quiz_attempt.user_answer) == normalize_answer(correct_answer)

    @quiz_attempt.is_correct = is_correct
    @quiz_attempt.score_awarded = is_correct ? 10 : 0

    @quiz_attempt.attempt_date = Date.current
    @quiz_attempt.question_order = 1

    if @quiz_attempt.save
      result_message = @quiz_attempt.is_correct ? "大正解！🎉 10点を獲得しました！" : "残念、不正解です。😥"
      redirect_to root_path, notice: result_message
    else
      @daily_quiz = daily_quiz
      render :new, status: :unprocessable_entity
    end
  end

  private
  def quiz_attempt_params
    params.require(:quiz_attempt).permit(:daily_quiz_id, :user_answer)
  end

  def normalize_answer(answer)
    answer.to_s.strip.gsub(/[　\s]/, '').downcase
  end
end
