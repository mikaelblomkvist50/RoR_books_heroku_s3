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
<br>

<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>
```
