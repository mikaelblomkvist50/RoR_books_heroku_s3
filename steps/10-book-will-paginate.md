```ruby
gem 'will_paginate', '~> 3.1', '>= 3.1.6'
gem 'will_paginate-bootstrap4', '~> 0.2.2'
```

<pre><code>
$ <b>bundle install --without production</b>
</pre></code>

`app/controllers/books_controller.rb`:
```ruby
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.paginate(:page => params[:page], :per_page => 3).order(:title)
  end
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
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @books.each do |book| %>
      <tr>
        <td><%= book.title %></td>
        <td><%= book.description %></td>
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

<pre><code>
$ <b>mkdir app/assets/stylesheets/bootstrap_override</b>
$ <b>touch app/assets/stylesheets/bootstrap_override/will_pagination.scss</b>
$ <b>touch app/assets/stylesheets/bootstrap_override/button.scss</b>
$ <b>touch app/assets/stylesheets/bootstrap_override/anchor.scss</b>
</pre></code>

`app/assets/stylesheets/bootstrap_override/will_pagination.scss`:
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

`app/assets/stylesheets/bootstrap_override/button.scss`:
```css
.btn-heroku {
    color: #fff;
    background-color: #5f4987;
    border-color: #5f4987;
}

.btn-heroku:hover {
    color: #fff;
    background-color: #8B008B;
    border-color: #8B008B;
}
```

`app/assets/stylesheets/bootstrap_override/anchor.scss`:
```css
a {
  color: #5f4987;
}
```

`app/assets/stylesheets/application.scss`:
```css
// Custom bootstrap variables must be set or imported *before* bootstrap.
@import "bootstrap";
@import 'bootstrap_override/will_pagination';
@import 'bootstrap_override/button';
@import 'bootstrap_override/anchor';
```
