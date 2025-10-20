class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts.order(post_date: :desc)
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
      redirect_to posts_path, notice: "日記とクイズを投稿しました！"
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
    params.require(:post).permit(:post_date, :image_url, :content, daily_quiz_attributes: [:id, :question_text, :correct_answer, :user_id])
  end
end