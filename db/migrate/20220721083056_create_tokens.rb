# frozen_string_literal: true

class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :token, null: false
      t.references :user, index: true
      t.timestamps
    end

    add_index :tokens, :token
  end
end
