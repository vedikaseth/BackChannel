class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :authorize , :only =>  :new ; :edit ; :update ; :create ; :destroy ; :generate_report ; :report

  def index
    @postCreatedSinceLastWeek   = {}
    @postCreatedEarlier = {}
    @mostActivePosts ={}
    @posts = []
     if params[:search_by].nil? and params[:search_text].nil?
       session[:search_by] = nil;
       session[:search_text] = nil;
       @posts = Post.all

     else
       session[:search_by] =  params[:search_by]
       session[:search_text] =  params[:search_text]
       if params[:search_by]=="Category"
         @posts = Post.find_all_by_category_id(Category.find(:all, :conditions => ['categoryName LIKE ?', params[:search_text]] ))
       elsif params[:search_by]=="User"
         @posts = Post.find_all_by_user_id(User.find(:all, :conditions => ['userName LIKE ?', params[:search_text]] ))
       elsif params[:search_by]=="Content"
         @posts = Post.where('postText LIKE ?', "%#{params[:search_text]}%")
       elsif params[:search_by]=="Tag"
         tag = Tag.where('tagText LIKE ?', "% #{params[:search_text]} %")
         if !tag.nil?
           tag.each do |tag|
             @posts  <<  Post.find(tag.post_id)
           end
         end
       end

     end

    @posts.each do |post|
      postVotesObj = PostVote.find_all_by_post_id(post.id)
      postVotes = postVotesObj.length

      if (Time.now.to_date - post.created_at.to_date >= -1 and Time.now.to_date - post.created_at.to_date <= 6)
        @postCreatedSinceLastWeek[post] = postVotes
      else
        @postCreatedEarlier[post] = postVotes

        end

    end



    activePosts =   find_most_active_post(@postCreatedSinceLastWeek)
    activePosts =   activePosts.sort_by{|k,w| w}.reverse
    activePosts.each do |post, weight|
    postVotesObj = PostVote.find_all_by_post_id(post.id)
    postVotes = postVotesObj.length
    @mostActivePosts[post] =   postVotes
     end

    @postCreatedEarlier= @postCreatedEarlier.sort_by{|k,v| v}.reverse


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end




  end

  # GET /posts/1
  # GET /posts/1.json
  def show


    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
      format.js
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    #tags_string_array = Tag.find_all_by_post_id(params[:id])
    #@tags_string = ""
    #tags_string_array.each do |a|
    #  @tags_string =  a.tagText +  @tags_string
    #    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        if(!params[:tags_string].nil?)
        tag_array = []
        tag_array = request.params[:tags_string].split(';')
        tag_array.each do |a|
          tags = Tag.new
          tags.tagText = " "+a + " "
          tags.post_id = @post.id
          tags.save
        end
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    if(!params[:tags_string].nil?)
    tag_array = []
    tag_array = params[:tags_string].split(';')
    tag_array.each do |a|
      tags = Tag.new
      tags.tagText = " "+a + " "
      tags.post_id = @post.id
      tags.save
    end
    end
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def generate_report
    @post_array = []

    if !params['no_of_days'].blank? && params['no_of_days'].to_i.to_s == params['no_of_days']

      new_date = Time.now.to_date - params['no_of_days'].to_i
      @post = Post.all

      @post.each do |post|
        if post.created_at.to_date > new_date
          @post_array << post
        end

      end
      @post_array.sort_by!{|a| a.created_at}
      @post_array.reverse!

    else
      session[:error] = "report error"
      redirect_to :action => 'report'
    end

  end


  def report
    if (session[:error] == "report error")
      @report_error= 1
      session[:error]= 'nil'
    end
  end

  def search_for_post
    @posts = []
    if params[:search_by]=="Category"
      @posts = Post.find_all_by_category_id(Category.find_all_by_categoryName(params[:search_text]))
    elsif params[:search_by]=="User"
      @posts = Post.find_all_by_user_id(User.find_by_userName(params[:search_text]))
    elsif params[:search_by]=="Content"
      @posts = Post.where('postText LIKE ?', "%#{params[:search_text]}%")
    elsif params[:search_by]=="Tag"
      tag = Tag.where('tagText LIKE ?', "% #{params[:search_text]} %")
      if !tag.nil?
      tag.each do |tag|
        @posts  <<  Post.find(tag.post_id)
      end
        end
    end

    @postHash  = {}


    if !@posts.empty?


    @posts.each do |post|
      postVotesObj = PostVote.find_all_by_post_id(post.id)
      postVotes = postVotesObj.length

      @postHash[post] = postVotes


    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end

    end
  end

  def search_post_show
    @post = Post.find(params[:id])


  end

  def find_most_active_post (postHash)

    postWeightHash = {}


    postHash.each do |post, votes|
          postVoteWeight  = votes * (0.30)

          comments =      Comment.find_all_by_post_id(post.id)
          commentWeight = comments.length * 0.20
          commentVote = 0
          comments.each do |comment|
            commentVote =    commentVote + CommentVote.find_all_by_post_id_and_comment_id(post.id,comment.id).length
          end
          commentVoteWeight =   commentVote * 0.10
          dateWeight = (Time.now.to_date - post.created_at.to_date) * 0.40
          total =    postVoteWeight +   commentWeight  + commentVoteWeight - dateWeight

          postWeightHash[post] = total
    end

         return postWeightHash
  end

end
