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
      redirect_to root_path, alert: "挑戦できるクイズがありません。日記をもっと投稿しましょう！"
      return
    end

    # 新しいクイズ挑戦インスタンスを作成し、ビューに渡す
    @quiz_attempt = current_user.quiz_attempts.build(daily_quiz: @daily_quiz)
  end

  def create
    @quiz_attempt = current_user.quiz_attempts.build(quiz_attempt_params)

    # 正解を取得
    daily_quiz = @quiz_attempt.daily_quiz
    correct_answer = daily_quiz.correct_answer

    # 採点ロジック
    # 大文字・小文字、全角・半角のスペースなどを無視して判定（より柔軟な判定）
    is_correct = normalize_answer(@quiz_attempt.user_answer) == normalize_answer(correct_answer)

    # 結果とポイントをインスタンスにセット
    @quiz_attempt.is_correct = is_correct
    @quiz_attempt.score_awarded = is_correct ? 10 : 0 # 正解なら10点、不正解なら0点

    if @quiz_attempt.save
      redirect_to root_path, notice: "解答を保存しました。結果は後ほど確認できます！"
    else
      @daily_quiz = daily_quiz # newテンプレート再表示のために必要
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
