ActiveRecord::Schema.define(:version => 0) do
  create_table :posts, :force => true do |t|
    t.string :title
    t.datetime :published_at
    t.timestamps
  end
end
