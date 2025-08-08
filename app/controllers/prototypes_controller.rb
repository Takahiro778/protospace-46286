class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_prototype, only: %i[show edit update destroy]
  before_action :authorize_owner!, only: %i[edit update destroy]

  def index
    @prototypes = Prototype.includes(:user).order(created_at: :desc)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: '投稿しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment  = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: '更新しました。'
    else
      flash.now[:alert] = '更新に失敗しました。入力内容を確認してください。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: '削除しました。'
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def authorize_owner!
    redirect_to root_path, alert: '権限がありません。' unless current_user == @prototype.user
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end
end
