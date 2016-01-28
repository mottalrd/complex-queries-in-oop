require 'active_record'

def init_db
  ActiveRecord::Schema.define do
    drop_table :players if ActiveRecord::Base.connection.data_source_exists? :players
  end

  ActiveRecord::Schema.define do
    create_table :players do |t|
      t.string :forename
      t.string :surname
      t.date :birth_date
      t.string :role
      t.string :nationality
      t.string :preferred_foot
      t.integer :shoots
      t.integer :goals
      t.integer :assists
      t.integer :passes
      t.integer :successful_passes
      t.string :team_name
    end
  end
end

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :database => "football_blog_post"
)

init_db