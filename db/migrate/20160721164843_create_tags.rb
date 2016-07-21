class CreateTags < ActiveRecord::Migration
  def change
    create_table(:tags) do |t|
      t.column(:name, :varchar)
      t.timestamps()
    end
  end
end
