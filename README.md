This is the blog I want to use for my personal website (http://www.nicolaracco.com). It's intended to be a multilanguage blog with simple content management.
It's built around the model Content (and its 'brothers': Image and Attachment), used for both static and dynamic contents. Each content belongs to a category used as group and to create SEO-friendly urls.
At the moment it's far to be complete. It lacks AJAX features, Sitemap, RSS feeds, Search engine. There are Tags but there isn't a Tag Cloud feature. A content can be written using Textile, and a little hack allow to integrate RedCloth with CodeRay to provide syntax highlighting functionalities for the code written in a content.
This blog is, at the moment, a work made in the last weekend. In fact I tried to accomplish this work in three days and I couldn't find a bit of time to write test classes, and I think I'll regret in future :).

#Requirements
- Ruby 1.9
- Rails 3.0.0.beta3
- Mysql

#To install

Admin user:
Copy 'dist/seeds.rb' to 'db/seeds.rb' and edit it to change the author fields. So, for example, the line:
        Author.create(:username => 'admin', :email => 'admin@mysite.com', :password => 'adminPass').save
will become:
        Author.create(:username => 'Nicola', :email => 'nicola@nicolaracco.com', :password => 'myPassword').save

Devise: Copy 'dist/devise.rb' to 'config/initializers/devise.rb' and edit it to fit your needs

Database: Create 'config/database.yml' and set it properly

Mail Setup: Copy 'dist/mail_setup.rb' to 'config/initializers/mail_setup.rb' and edit it to set how ActionMailer should send emails

Finally, setup the environment with:
        bundle install
        rake db:setup
