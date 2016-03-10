class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  load_and_authorize_resource only: [:new]

  def index
    #@posts = Post.all
    @posts = Post.page params[:page] #Kaminari分頁功能
  end

  def show
    #@comments = @post.comments.all
    @comments = @post.comments.page params[:page] #Kaminari分頁功能
  end

  def new
    #@post = Post.new
    @group = Group.find(params[:group_id])
    @post = @group.posts.new
  end

  def edit
  end

  def create
    #@post = Post.new(post_params)
    @group = Group.find(params[:group_id])
    @post = @group.posts.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        #format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.html { redirect_to @group, notice: '文章已建立！' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        #format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.html { redirect_to group_path(@group), notice: '文章已更新！' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      #format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.html { redirect_to group_path(@group), notice: '文章已刪除！' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      #@post = Post.find(params[:id])
      @group = Group.find(params[:group_id])
      @post = @group.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :group_id, :user_id)
    end
end
