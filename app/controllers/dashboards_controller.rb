class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # 最新のクイズ挑戦結果を1件取得
    @latest_attempt = current_user.quiz_attempts.order(created_at: :desc).first

    # ユーザーがまだ回答していないクイズの数
    user_posts_ids = current_user.posts.pluck(:id)
    answered_quiz_ids = current_user.quiz_attempts.pluck(:daily_quiz_id)

    @remaining_quiz_count = DailyQuiz
                              .where(post_id: user_posts_ids)
                              .where.not(id: answered_quiz_ids)
                              .count
  end
end
