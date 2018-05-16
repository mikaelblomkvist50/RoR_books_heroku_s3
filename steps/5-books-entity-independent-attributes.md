The **Book Entity** has 8 attributes. `id`, `title`, `description`, `slug`, `book_cover`, `user_id`, `created_at` and `updated_at`. However some of these attributes rely on gems and other Entities therefore we only need to establish the independent attributes for the time being. Which are `id`, `title`, `description`, `created_at` and `updated_at`.

<pre><code>
$ <b>rails generate scaffold Book title:string description:string</b>

$ <b>rake db:migrate</b>
== 20180228031958 CreateBooks: migrating ======================================
-- create_table(:books)
   -> 0.0012s
== 20180228031958 CreateBooks: migrated (0.0014s) =============================

$ <b>rm app/assets/stylesheets/scaffolds.scss</b>
</pre></code>
