# UserDecorator
class UserDecorator < ApplicationDecorator
  def minecraft_avatar
    if object.minecraft_uuid.present?
      "https://crafatar.com/avatars/#{object.minecraft_uuid}?overlay&size=64"
    else
      "https://crafatar.com/avatars/606e2ff0ed7748429d6ce1d3321c7838?overlay&size=64"
    end
  end

  def minecraft_skin_url
    return no_uuid_skin if object.minecraft_uuid.blank?
    "https://crafatar.com/renders/body/#{object.minecraft_uuid}?scale=4&overlay"
  end

  private

  def no_uuid_skin
    "https://crafatar.com/renders/body/606e2ff0ed7748429d6ce1d3321c7838?scale=" \
      "4&overlay"
  end
end
