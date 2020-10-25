class CreateAuths < ActiveRecord::Migration[6.0]
  def change
    create_table :auths do |t|
      t.string :uuid
      t.string :secret_token

      t.timestamps
    end
  end
end
