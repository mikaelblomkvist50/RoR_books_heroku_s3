**MiniMagick** depends on a C program called **ImageMagick**.

<pre><code>
$ <b>brew install imagemagick</b>
</pre></code>

`Gemfile`:
```ruby
gem 'mini_magick', '~> 4.8'
````

<pre><code>
$ <b>bundle install --without production</b>
</pre></code>

`app/models/uploaders/book_cover_uploader.rb`:
```ruby
class BookCoverUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
.
.
.
# Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [200, 200]
  end

  version :small_thumb do
    process resize_to_fit: [100, 100]
  end
```

If you already have uploaded some images, they won't have thumbnails available. This is not a problem, as you can re-create them from the Rails Console:
<pre><code>
$ <b>rails console</b>
Running via Spring preloader in process 22717
Loading development environment (Rails 5.1.4)
2.4.1 :001 > Book.find_each { |book| book.book_cover.recreate_versions!(:thumb) if book.book_cover? }
</pre></code>

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

<%= link_to(image_tag(@book.book_cover.thumb.url, alt: 'Image'), @book.book_cover.url, target: '_blank') if @book.book_cover? %>

<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>
```

`app/views/books/index.html.erb`:
```html
<p id="notice"><%= notice %></p>

<h1>Books</h1>

<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Description</th>
      <th>Book Cover</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @books.each do |book| %>
      <tr>
        <td><%= book.title %></td>
        <td><%= book.description %></td>
        <%= link_to(image_tag(book.book_cover.small_thumb), book.book_cover.url, target: '_blank') %>
        <td><%= link_to 'Show', book %></td>
        <td><%= link_to 'Edit', edit_book_path(book) %></td>
        <td><%= link_to 'Destroy', book, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to 'New Book', new_book_path %>
<%= will_paginate @books, list_classes: %w(pagination justify-content-end) %>
```

If you already have uploaded some images, they won't have thumbnails available. This is not a problem, as you can re-create them from the Rails Console:
<pre><code>
$ <b>rails console</b>
Running via Spring preloader in process 22717
Loading development environment (Rails 5.1.4)
2.4.1 :001 > Book.find_each { |book| book.book_cover.recreate_versions!(:small_thumb) if book.book_cover? }
</pre></code>
