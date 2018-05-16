```ruby
gem 'friendly_id', '~> 5.2', '>= 5.2.3'
```

<pre><code>
$ <b>bundle install --without production</b>

$ <b>rails generate friendly_id</b>
Running via Spring preloader in process 98975
      create  db/migrate/20180228060225_create_friendly_id_slugs.rb
      create  config/initializers/friendly_id.rb
</pre></code>

Temp solution for Rails 5.1+ : Before running the migration, go into the generated migration file and specify the Rails version `db/migrate/20180228060225_create_friendly_id_slugs.rb`:
```ruby
class CreateFriendlyIdSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 50
      t.string   :scope
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type], length: { slug: 140, sluggable_type: 50 }
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], length: { slug: 70, sluggable_type: 50, scope: 70 }, unique: true
    add_index :friendly_id_slugs, :sluggable_type
  end
end
```

<pre><code>
$ <b>rake db:migrate</b>
== 20180228060225 CreateFriendlyIdSlugs: migrating ============================
-- create_table(:friendly_id_slugs)
   -> 0.0020s
-- add_index(:friendly_id_slugs, :sluggable_id)
   -> 0.0010s
-- add_index(:friendly_id_slugs, [:slug, :sluggable_type], {:length=>{:slug=>140, :sluggable_type=>50}})
   -> 0.0012s
-- add_index(:friendly_id_slugs, [:slug, :sluggable_type, :scope], {:length=>{:slug=>70, :sluggable_type=>50, :scope=>70}, :unique=>true})
   -> 0.0016s
-- add_index(:friendly_id_slugs, :sluggable_type)
   -> 0.0019s
== 20180228060225 CreateFriendlyIdSlugs: migrated (0.0083s) ===================

$ <b>rails generate migration add_slug_to_books slug:string:uniq</b>
Running via Spring preloader in process 99469
      invoke  active_record
      create    db/migrate/20180228061659_add_slug_to_books.rb

$ <b>rake db:migrate</b>
== 20180228061659 AddSlugToBooks: migrating ===================================
-- add_column(:books, :slug, :string)
   -> 0.0016s
-- add_index(:books, :slug, {:unique=>true})
   -> 0.0019s
== 20180228061659 AddSlugToBooks: migrated (0.0037s) ==========================
</pre></code>

`app/models/book.rb`:
```ruby
class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
```

Add `friendly` to the `set_book` method inside `app/controllers/books_controller.rb`:
```ruby
private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :description)
    end
end
```
