# frozen_string_literal: true

class CreateFishCard < ActiveRecord::Migration[5.1]
  def self.up
    create_table :fish_cards do |t|
      t.column :message, :string
    end
  end

  def self.down
    # drop_table, delete_column
  end
end
