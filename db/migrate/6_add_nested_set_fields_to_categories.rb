class AddNestedSetFieldsToCategories < ActiveRecord::Migration
  def change
    add_column :refinery_teams_categories, :parent_id, :integer
    add_column :refinery_teams_categories, :lft, :integer
    add_column :refinery_teams_categories, :rgt, :integer
    add_column :refinery_teams_categories, :depth, :integer

    Refinery::Teams::Category.add_translation_fields! slug: :string
  end
end