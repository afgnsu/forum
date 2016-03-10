class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  load_and_authorize_resource only: [:new, :edit, :update]


  def index
    #@comments = Comment.all
    @comments = Comment.page params[:page]
  end

  def show
  end

  def new
    #@comment = Comment.new
    @group = Group.find(params[:group_id])
    @post = @group.posts.find(params[:post_id])
    @comment = @post.comments.new
  end

  def edit
  end

  def create
    #@comment = Comment.new(comment_params)
    @group = Group.find(params[:group_id])
    @post = @group.posts.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.html { redirect_to group_post_path(@group,@post), notice: '留言已建立！' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        #format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.html { redirect_to group_post_path(@group,@post), notice: '留言已更新！' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      #format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.html { redirect_to group_post_path(@group,@post), notice: '留言已刪除！' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      #@comment = Comment.find(params[:id])
      @group = Group.find(params[:group_id])
      @post = @group.posts.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id)
    end
end
