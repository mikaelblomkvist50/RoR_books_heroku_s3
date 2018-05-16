`app/views/books/index.html.erb`:
```html
<p id="notice"><%= notice %></p>

<h1>Books</h1>

<% @books.each do |book| %>
  <h3><%= link_to book.title, book %></h3>
  <%# This way we get a link with the products name that points to the product %>
  <%# Because remember the ROUTE MAP for prefix 'book' is 'book GET /books/:id(.:format) books#show' %>
  <p><%= book.description %></p>
  <%= link_to(image_tag(book.book_cover.small_thumb), book.book_cover.url, target: '_blank') %>
  <td><%= link_to 'Edit', edit_book_path(book) %></td>
  <td><%= link_to 'Destroy', book, method: :delete, data: { confirm: 'Are you sure?' } %></td>
<% end %>

<br>

<%= link_to 'New Book', new_book_path, class: 'btn btn-primary float-right' %>
<%= will_paginate @books, next_label: '&raquo;', list_classes: %w(pagination justify-content-start) %>
```

`app/assests/stylesheets/bootstrap_override/will_pagination.scss`:
```css
.page-item.active .page-link {
    z-index: 1;
    color: #fff;
    background-color: #5f4987;
    border-color: #5f4987;
}

.pagination > li > a, .pagination > li > span {
  color: #5f4987;
}

.pagination {
  margin-top: 20px;
}
```

`app/assests/stylesheets/bootstrap_override/button.scss`:
```css
.btn-primary {
    color: #fff;
    background-color: #5f4987;
    border-color: #5f4987;
}

.btn-primary:hover {
    color: #fff;
    background-color: #8B008B;
    border-color: #8B008B;
}
```

`app/assests/stylesheets/application.scss`:
```css
// Custom bootstrap variables must be set or imported *before* bootstrap.
@import "bootstrap";
@import 'bootstrap_override/will_pagination';
@import 'bootstrap_override/anchor';
@import 'bootstrap_override/button';
```
