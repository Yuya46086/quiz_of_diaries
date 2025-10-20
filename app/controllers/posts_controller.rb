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
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "日記とクイズを投稿しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end
end

private

def post_params
  params.require(:post).permit(:post_date, :image_url, :content, daily_quiz_attributes: [:question_text, :correct_answer])
end