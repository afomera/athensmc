module ApplicationHelper
  def page_title(page_title)
    content_for(:title) { page_title }
  end

  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[
      flash_type.to_s
    ] ||
      flash_type.to_s
  end

  def forum_post_classes(forum_post)
    klasses = []
    klasses << "original-poster" if forum_post.user == @forum_thread.user
    klasses
  end

  def user_badges(user)
    badges = []
    if user.admin?
      badges << content_tag(:span, "Admin", class: "badge bg-danger")
    end
    if user.member?
      badges << content_tag(:span, "Member", class: "badge bg-success")
    end
    badges.join(" ").html_safe
  end

  def parameters_present?(keys)
    keys.any? { |param| params[param.to_sym].present? }
  end
end
