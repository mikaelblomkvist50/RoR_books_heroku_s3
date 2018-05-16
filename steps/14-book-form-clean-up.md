`Gemfile`:
```ruby
gem 'simple_form', '~> 3.5', '>= 3.5.1'
```

<pre><code>
$ <b>bundle install --without production</b>

$ <b>rails generate simple_form:install --bootstrap</b>
Running via Spring preloader in process 31477
      create  config/initializers/simple_form.rb
      create  config/initializers/simple_form_bootstrap.rb
       exist  config/locales
      create  config/locales/simple_form.en.yml
      create  lib/templates/erb/scaffold/_form.html.erb
===============================================================================

  Be sure to have a copy of the Bootstrap stylesheet available on your
  application, you can get it on http://getbootstrap.com/.

  Inside your views, use the 'simple_form_for' with one of the Bootstrap form
  classes, '.form-horizontal' or '.form-inline', as the following:

    = simple_form_for(@user, html: { class: 'form-horizontal' }) do |form|

===============================================================================
</pre></code>

`app/views/books/_form.html.erb`
```html
<%= simple_form_for(@book) do |f| %>
  <%= f.error_notification %>

  <div class="form-inputs">
    <%= f.input :title %>
    <%= f.input :description %>
  </div>

  <div class="form-group">
    <%= f.label :book_cover %>
    <%= f.file_field :book_cover %>
  </div>

  <div class="form-actions">
    <%= f.button :submit, class:'btn btn-primary' %>
  </div>
<% end %>
```
