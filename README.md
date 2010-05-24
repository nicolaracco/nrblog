This is the blog I'm developing to use for my personal website (http://www.nicolaracco.com). It's intended to be a multilanguage blog with simple content management. Actually I'm hosting it on http://dev.nicolaracco.com.
It's licensed under GPL v2.0, and I'm hosting it here because I think it could be a good starting point for newbies who want to learn RoR.
It's built around the model Content (and its 'brothers': Image and Attachment), used for both static and dynamic contents. Each content belongs to a category used as group and to create SEO-friendly urls.
At the moment it's far to be complete. It still lacks a bit of AJAX, and it lacks RSS feeds, Search engine. There are Tags (and a Tag Cloud feature) and Sitemap. A content can be written using Textile, and a little hack allows to integrate RedCloth with CodeRay to provide syntax highlighting functionalities for the code written in a content.
This blog is, at the moment, a work made in the last weeks. In fact I tried to accomplish this work using my free time and I couldn't find a bit of time to write test classes, and I think I'll regret in future :).

##Last Changes

I removed my own commenting system in favor of IntenseDebate

#Requirements
- Ruby 1.9
- Rails 3.0.0.beta3
- Mysql

#To install

##Fetch a copy
        git clone git://github.com/nicolaracco/nrblog.git ./nrblog
        cd nrblog
        git submodule init # => These two commands download for you the latest JQuery-UJS version available
        git submodule update 

##Plugins and libraries
You need to have installed only the bundler gem. If you don't have it:
        gem install bundler
Then, update your bundle:
        bundle install

##Configuration

Admin user:
Copy 'dist/seeds.rb' to 'db/seeds.rb' and edit it to change the author fields. So, for example, the line:
        Author.create(:username => 'admin', :email => 'admin@mysite.com', :password => 'adminPass').save
will become:
        Author.create(:username => 'Nicola', :email => 'nicola@nicolaracco.com', :password => 'myPassword').save

Devise: Copy 'dist/devise.rb' to 'config/initializers/devise.rb' and edit it to fit your needs

Database: Create 'config/database.yml' and set it properly

Mail Setup: Copy 'dist/mail_setup.rb' to 'config/initializers/mail_setup.rb' and edit it to set how ActionMailer should send emails

Intense Debate: Copy 'dist/intense_debate.rb' to 'config/initializers/intense_debate.rb' end edit it filling your IntenseDebate IDs.

Finally, setup the environment with:
        bundle install
        rake db:setup
