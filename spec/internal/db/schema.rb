ActiveRecord::Schema.define do
  create_table "users", force: true do |t|
    t.string      :username,           null: false
    t.inet        :ip_whitelist,       array: true
    t.timestamps                       null: false
  end
end
