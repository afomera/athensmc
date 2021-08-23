class CreateForumCategories < ActiveRecord::Migration[5.1]
  def up
    create_table :forum_categories do |t|
      t.string :name
      t.string :slug
      t.string :color, default: "#000000"
    end

    ForumCategory.reset_column_information

    {
      "General" => "#4ea1d3",
      # blue
      "Modded Minecraft" => "#ff7473",
      # red
      "Snapshot/Vanilla Minecraft" => "#58C9B9",
      # teal / green
      "Site Feedback" => "#F29B34"
    }.each do |name, color|
      ForumCategory.where(name: name, color: color).first_or_create
    end
  end

  def down
    drop_table :forum_categories
  end
end
