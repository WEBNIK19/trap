class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :trap_id
      t.string :method
      t.string :remote_ip
      t.string :params
      t.string :scheme
      t.text :headers
      t.text :cookies
      t.text :request_env

      t.timestamps
    end
  end
end
