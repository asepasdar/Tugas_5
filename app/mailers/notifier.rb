class Notifier < ActionMailer::Base
  default from: "Blog Application <a.darmawan93@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.confirmation.subject
  #
  def confirmation(post)
    @post = post
    @owner = post.user.username
    @commenter = post.comments.last
    mail to: post.user.email, subject: "Notification Article"
  end
end
