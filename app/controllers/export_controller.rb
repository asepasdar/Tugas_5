class ExportController < ApplicationController
	def show
		@post = Post.find(params[:id])
		respond_to do |format|
		  format.xls
		end
	end
end