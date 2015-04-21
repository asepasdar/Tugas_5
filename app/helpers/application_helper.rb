module ApplicationHelper
	def check_page
		if current_page?(root_path)
			"All Posts"
		elsif current_page?(about_path)
			"About"
		else
			link_to 'Back to All Posts', root_path
		end
	end

	def check_status_login
		if user_signed_in?
			render 'layouts/layouts_render/profile'
		else
			render 'layouts/layouts_render/login'
		end
	end

	def permit(post)
		if user_signed_in?
			if post.user.email == current_user.email
				render "posts/permit"
			else
				""	
			end
		else
			""
		end
	end

	def comment_form
		if user_signed_in?
			"<h3>Add a comment:</h3>".html_safe
			render "comments/form"
		else
			"<div class= 'alert'>
				You need sign in before add a comment
			</div>".html_safe
		end
	end

	def delete_action
		if user_signed_in?
			link_to 'Delete', [comment.post, comment], method: :delete, class: "button", data: {confirm: "Are you sure?"}
		else
			""
		end
	end
end