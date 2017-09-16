# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :fish_cards do
      primary_key :id
      String :message, null: false
    end
  end
end
