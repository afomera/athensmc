module ApplicationHelper
  def page_title(page_title)
    content_for(:title) { page_title }
  end

  def body_classes
    user_signed_in? ? "logged-in" : "logged-out"
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

  def body_data_page
    action =
      case action_name
      when "create"
        "new"
      when "update"
        "edit"
      else
        action_name
      end
        .downcase

    path = controller.controller_path.split("/")
    namespace = path.first if path.second

    [namespace, controller.controller_name, action].compact.join(":")
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
