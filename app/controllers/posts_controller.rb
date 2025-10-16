class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
    @post = current_user.posts.build
    @post.build_quiz
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect to posts_path, notice: "日記とクイズを投稿しました！"
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
  params.require(:post).permit(:post_date, :image_url, :content, quiz_attributes: [:question_text, :correct_answer])
end