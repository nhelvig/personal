# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( hover.css )
Rails.application.config.assets.precompile += %w( picture-slideshow.js )
Rails.application.config.assets.precompile += %w( travel-map.js )
Rails.application.config.assets.precompile += %w( pics.css )
Rails.application.config.assets.precompile += %w( review.css )
Rails.application.config.assets.precompile += %w( transactions.css )
Rails.application.config.assets.precompile += %w( welcome.css )
Rails.application.config.assets.precompile += %w( articles.css )
Rails.application.config.assets.precompile += %w( articles.css )
Rails.application.config.assets.precompile += %w( highcharts.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css.erb, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
