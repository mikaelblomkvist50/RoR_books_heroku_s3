`Gemfile`:
```ruby
group :production do
  gem 'pg', '0.21.0'
  gem 'fog', '~> 1.42'
end
```

`app/models/uploaders/book_cover_uploader.rb`:
```ruby
class BookCoverUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
```

<pre><code>
$ <b>touch config/initializers/carrier_wave.rb</b>
</pre></code>

`config/initializers/carrier_wave.rb`:
```ruby
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
    config.fog_directory = ENV['S3_BUCKET']
  end
end
```

Once you have an **AWS root account** go to **Services** click **IAM**, click **Users**, click **Add User**, **User name** = **BooksHerokuRoR**. Tick **Programmatic access** and Tick **AWS Management Console access**. Click **Next: Permissions**, click **Attach existing policies directly**, attach **AmazonS3FullAccess**. Click **Next: Review**, click **Create: User**.

Then click **Downlaod .csv**.

Still winin **AWS root account** go to **Services** click **S3**, click **Create bucket**, **Bucket name** = **booksherokuror**, **Region** = **Asia Pacific (Sydney)**, click **Create**.

<pre><code>
$ <b>heroku config:set S3_ACCESS_KEY=asdfjkl;</b>
Setting S3_ACCESS_KEY and restarting ⬢ books-heroku-ror... done, v10
S3_ACCESS_KEY: asdfjkl;

$ <b>heroku config:set S3_SECRET_KEY=asdfjkl;</b>
Setting S3_SECRET_KEY and restarting ⬢ books-heroku-ror... done, v11
S3_SECRET_KEY: asdfjkl;

$ <b>heroku config:set S3_BUCKET=asdfjkl;</b>
Setting S3_BUCKET and restarting ⬢ books-heroku-ror... done, v12
S3_BUCKET: asdfjkl;
</pre></code>

`.gitignore`:
```
# Ignore uploaded test images.
/public/uploads
```

<pre><code>
$ <b>git push heroku master</b>

$ <b>heroku pg:reset DATABASE</b>
 ▸    WARNING: Destructive action
 ▸    postgresql-horizontal-22164 will lose all of its data
 ▸
 ▸    To proceed, type books-heroku-ror or re-run this command with --confirm books-heroku-ror

> books-heroku-ror
Resetting postgresql-horizontal-22164... done

$ <b>heroku run rails db:migrate</b>

$ <b>heroku run rails db:seed</b>

$ <b>heroku open</b>
</pre></code>
