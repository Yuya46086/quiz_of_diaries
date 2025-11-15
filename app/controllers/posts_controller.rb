class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @selected_year = params[:year].present? ? params[:year].to_i : Time.zone.now.year
    @selected_month = params[:month].present? ? params[:month].to_i : Time.zone.now.month
    
    start_date = Time.zone.local(@selected_year, @selected_month, 1).beginning_of_day
    end_date = start_date.end_of_month.end_of_day
    
    @posts = current_user.posts
                         .where(post_date: start_date..end_date)
                         .order(post_date: :desc)
    
    @available_months = generate_month_list
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
    @post.build_daily_quiz
  end

  def create
    quiz_params = post_params[:daily_quiz_attributes].merge(user_id: current_user.id)
    modified_post_params = post_params.merge(daily_quiz_attributes: quiz_params)
    @post = current_user.posts.build(modified_post_params)
    if @post.save
      redirect_to posts_path(@post), notice: "日記の投稿とクイズの作成に成功しました！新しいクイズに挑戦してみましょう！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    
    if @post.user != current_user
      redirect_to root_path, alert: "他人の日記は編集できません。"
    end
  end

  def update
    @post = Post.find(params[:id])

    unless @post.user == current_user
      redirect_to root_path, alert: "他人の日記は編集できません。"
    end

    if @post.update(post_params)
      redirect_to post_path(@post), notice: "日記とクイズを更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @post = Post.find(params[:id])

    unless @post.user == current_user
      return redirect_to root_path, alert: "他人の日記は削除できません。"
    end

    @post.destroy
    redirect_to root_path, notice: "日記を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:post_date, :photo, :content, daily_quiz_attributes: [:id, :question_text, :correct_answer, :user_id, :alternate_answers])
  end

  def generate_month_list
    months = []
    6.times do |i|
      date = Time.zone.now.months_ago(i)
      months << { year: date.year, month: date.month, display: date.strftime("%Y年%m月") }
    end
    months.reverse
  end
end