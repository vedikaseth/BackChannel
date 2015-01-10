class CommentVotesController < ApplicationController
  # GET /comment_votes
  # GET /comment_votes.json
  before_filter :authorize
  def index
    @comment_votes = CommentVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comment_votes }
    end
  end

  # GET /comment_votes/1
  # GET /comment_votes/1.json
  def show
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/new
  # GET /comment_votes/new.json
  def new
    @comment_vote = CommentVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment_vote }
    end
  end

  # GET /comment_votes/1/edit
  def edit
    @comment_vote = CommentVote.find(params[:id])
  end

  # POST /comment_votes
  # POST /comment_votes.json
  def create
     if ( !params[:post_id].nil? and !params[:user_id].nil? and !params[:comment_id].nil?)
    @comment_vote = CommentVote.new(:user_id => params[:user_id], :post_id => params[:post_id], :comment_id => params[:comment_id])
     else
       @comment_vote = CommentVote.new(params[:comment_vote])
      end
    if !params[:post_id].nil?
    @post = Post.find(params[:post_id])



    respond_to do |format|
      if @comment_vote.save
        format.html { redirect_to @post, notice: 'Successfully voted.' }
        format.json { render json: @post, status: :created, location: @post }
        format.js
      else
        format.html { redirect_to @post, notice: 'You cannot vote twice' }
        format.json { render json: @post, status: :created, location: @post }
        format.js
        end
    end

    else
      respond_to do |format|
        if @comment_vote.save
          format.html { redirect_to @comment_vote, notice: 'Comment vote was successfully created.' }
          format.json { render json: @comment_vote, status: :created, location: @comment_vote }
        else
          format.html { render action: "new" }
          format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /comment_votes/1
  # PUT /comment_votes/1.json
  def update
    @comment_vote = CommentVote.find(params[:id])

    respond_to do |format|
      if @comment_vote.update_attributes(params[:comment_vote])
        format.html { redirect_to @comment_vote, notice: 'Comment vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comment_votes/1
  # DELETE /comment_votes/1.json
  def destroy
    if ( !params[:post_id].nil? and !params[:user_id].nil? and !params[:comment_id].nil?)
    @comment_vote = CommentVote.find_by_post_id_and_user_id_and_comment_id(params[:post_id],params[:user_id],params[:comment_id])
    else
      @comment_vote = CommentVote.find(params[:id])
    end
    @comment_vote.destroy
    if !params[:post_id].nil?

    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.html { redirect_to @post, notice: 'Successfully unvoted.' }
      format.json { head :no_content }
    end
    else
      respond_to do |format|
        format.html { redirect_to comment_votes_url }
        format.json { head :no_content }
      end

    end
  end


  end
