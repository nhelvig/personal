#bin/bash

ps -o pid -o command  | grep rails | awk '{print $1}' | xargs kill -9
bin/rake db:drop db:create db:migrate
rails s
