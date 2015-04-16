class ListController < ApplicationController
	before_action :authenticate_user!
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
end
