class AddSlugToExamples < ActiveRecord::Migration[6.0]
  def change
    add_column :examples, :slug, :string
    add_index :examples, :slug, unique: true
  end
end
