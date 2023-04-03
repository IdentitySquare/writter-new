class PostsMailer < ApplicationMailer
  before_action :set_user
  before_action :set_posts

  def daily_mail  
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "New Posts from writers you follow"
    )
  end

  def weekly_mail
    mail(
      to: "#{@user.name} <#{@user.email}>",
      subject: "New Posts from writers you follow"
    )
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_posts
    @posts = Post.with_discarded.find(params[:post_ids])
  end
end
