class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	def index
		if params[:tag_list]
			@posts = Post.paginate(:page => params[:page], :per_page => 10).tagged_with(params[:tag_list]).order('created_at DESC')
		else
			@posts = Post.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
		end
		respond_to do |format|
		  format.html
		  format.csv { send_data text: @posts.to_csv }
		  format.xls #{ send_data text: @posts.to_csv(col_sep: "\t") }
		  format.js
		end
	end
	
	def import
		Post.import(params[:file])
		redirect_to root_url, notice: "Posts imported."
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to root_path
	end

	def list
		@posts = Post.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
	end

	def status
		
	end

	private
		def post_params
			params.require(:post).permit(:title, :body, :tag_list)
		end
end
