<pre><code>
$ <b>rails generate controller Welcome index</b>
</pre></code>

`config/routes.rb`:
```ruby
Rails.application.routes.draw do
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

<pre><code>
$ <b>touch app/views/layouts/navbar.html.erb</b>
</pre></code>

`app/views/layouts/application.html.erb`:
```
<!DOCTYPE html>
<html>
  <head>
    <title>BooksHerokuRor</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= render "layouts/navbar" %>
    <div class="container">
      <%= yield %>
    </div>
  </body>
</html>
```

Go to [Codepen](https://codepen.io/JuliusRobertOppenheimer/pen/JpwWRw?editors=1000) and grab the HTML for the Navbar that suits your needs. Then past that into `app/views/layouts/_navbar.html.erb`
