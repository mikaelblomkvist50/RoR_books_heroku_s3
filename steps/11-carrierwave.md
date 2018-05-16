Unlike both ***Magicks** Carierwave it self doesn't require a C program called **ImageMagick**. But when we use **MiniMagick** or **RMagick** to resize images that's when will need the dependenciy **$ brew install imagemagick**.

```ruby
gem 'carrierwave', '~> 1.2', '>= 1.2.2'
```
<pre><code>
$ <b>bundle install --without production</b>


$ <b>rails generate uploader BookCover</b>
Running via Spring preloader in process 20655
      create  app/uploaders/book_cover_uploader.rb

$ <b>rails generate migration add_book_cover_to_books book_cover:string</b>
Running via Spring preloader in process 20986
      invoke  active_record
      create    db/migrate/20180228150231_add_book_cover_to_books.rb
#How I read this command
#Add book_cover attribute to book entity where the book_cover attribute is a sting.

$ <b>rake db:migrate</b>
== 20180228150231 AddBookCoverToBooks: migrating ==============================
-- add_column(:books, :book_cover, :string)
   -> 0.0013s
== 20180228150231 AddBookCoverToBooks: migrated (0.0014s) =====================
</pre></code>

`app/models/book.rb`:
```ruby
class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  mount_uploader :book_cover, BookCoverUploader
end
```

`app/views/books/_form.html.erb`:
```html
<%= form_with(model: book, local: true) do |form| %>
  <% if book.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(book.errors.count, "error") %> prohibited this book from being saved:</h2>

      <ul>
      <% book.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= form.label :title %>
    <%= form.text_field :title, id: :book_title %>
  </div>

  <div class="field">
    <%= form.label :description %>
    <%= form.text_field :description, id: :book_description %>
  </div>

  <div class="field">
    <%= form.label :book_cover %>
    <%= form.file_field :book_cover, id: :book_cover %>
  </div>

  <div class="actions">
    <%= form.submit %>
  </div>
<% end %>
```

`app/controllers/books_controller.rb`:
```ruby
private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :description, :book_cover)
    end
end
```

`app/views/books/show.html.erb`:
```html
<p id="notice"><%= notice %></p>

<p>
  <strong>Title:</strong>
  <%= @book.title %>
</p>

<p>
  <strong>Description:</strong>
  <%= @book.description %>
</p>

<%= image_tag(@book.book_cover.url, alt: "Image") if @book.book_cover %>

<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>
```

`app/models/uploaders/book_cover_uploader.rb`:
```ruby
.
.
.
# Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
```

`app/models/book.rb`:
```ruby
class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  mount_uploader :book_cover, BookCoverUploader
  validate :book_cover_size

  private

    # Validates the size of an uploaded picture.
    def book_cover_size
      if book_cover.size > 2.megabytes
        errors.add(:book_cover, "should be less than 2MB")
      end
    end
end
```

**If**  you add a the new attribute and it isn't a Foreign Key.
 Whenever you  add a new attribute to an existing entity/model. Your intuition should be edit `_form.html.erb`, edit
 `enitys_controller`'s `entity_params` method,  and edit `show.html.erb`.

**else** you add a  new attribute and it is a Foreign Key.
Your intuition should be to add **associations** (belongs_to, has_one, has_many, has_and_belongs_to_many)  between those entities.

**end**

By the way entity/model are interchangeable in my mind.
