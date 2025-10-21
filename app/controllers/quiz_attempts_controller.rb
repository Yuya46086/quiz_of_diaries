class QuizAttemptsController < ApplicationController
  before_action :authenticate_user!

  def new
    # ユーザーが投稿した日記のID一覧
    user_post_ids = current_user.posts.pluck(:id)
    
    # まだ挑戦レコードがない、かつ、ユーザーが投稿したPostに紐づくDailyQuizを取得
    @daily_quiz = DailyQuiz
                    .where(post_id: user_post_ids) # 自分が投稿した日記のクイズから選ぶ
                    .where.not(id: current_user.quiz_attempts.pluck(:daily_quiz_id)) # 既に挑戦済みのクイズを除外
                    .order('RAND()') # ランダムに並び替える
                    .first
    
    if @daily_quiz.nil?
      redirect_to root_path, alert: "挑戦できるクイズがありません！日記をもっと投稿しましょう。"
      return
    end

    # 新しいクイズ挑戦インスタンスを作成し、ビューに渡す
    @quiz_attempt = current_user.quiz_attempts.build(daily_quiz: @daily_quiz)
  end

  def create
  end
end
