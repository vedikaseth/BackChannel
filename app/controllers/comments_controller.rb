class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  before_filter :authorize
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    session[:currentPostId] = params[:post_id]
    @comment = Comment.find(params[:id])

  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.new
    @comment = Comment.new(params[:comment])
    if  !params[:comment]['post_id'].nil?
    @post = Post.find(params[:comment]['post_id'])

    #redirect_to(:controller => 'posts', :action => 'show')
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
        format.js

      end
    end
    else
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
          format.json { render json: @comment, status: :created, location: @comment }
        else
          format.html { render action: "new" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @post = Post.new
    @comment = Comment.find(params[:id])
    if !session[:currentPostId].nil?
    @post = Post.find(session[:currentPostId])
    session[:currentPostId] = nil
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @post, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    else
      respond_to do |format|
        if @comment.update_attributes(params[:comment])
          format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end

    end

  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.new
    @comment = Comment.find(params[:id])
    @comment.destroy
    if(!params[:post_id].nil?)
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.html { redirect_to @post, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end

  else
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end
  end

  end
