class ExportController < ApplicationController
	def index
		@posts = Post.all
		respond_to do |format|
		  format.xls
		end
	end
	def show
		@post = Post.find(params[:id])
		respond_to do |format|
		  format.xls
		end
	end
end