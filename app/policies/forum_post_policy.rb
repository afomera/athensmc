# ForumPostPolicy
class ForumPostPolicy < ApplicationPolicy
  attr_reader :user, :forum_post

  def initialize(user, forum_post)
    @user = user
    @forum_post = forum_post
  end

  %w[index show].each { |action| define_method("#{action}?") { true } }

  %w[new create].each { |action| define_method("#{action}?") { true } }

  %w[edit update].each do |action|
    define_method("#{action}?") { owner?(forum_post) || user.admin? }
  end

  %w[destroy].each { |action| define_method("#{action}?") { owner?(forum_post) || user.admin? } }

  # ForumPostPolicy Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
