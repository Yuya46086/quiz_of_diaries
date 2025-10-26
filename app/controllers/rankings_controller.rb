class RankingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User
              .left_joins(:quiz_attempts)
              .group(:id)
              .select('users.*, SUM(COALESCE(quiz_attempts.score_awarded, 0)) AS total_score')
              .order('total_score DESC')
              .limit(10) # トップ10を表示
  end
end
