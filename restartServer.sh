#bin/bash

cd /Users/nhelvig/personal
ps -o pid -ef  | grep rails | grep -v "grep" | awk '{print $1}' | xargs kill -9
echo "Dropping db..."
/Users/nhelvig/personal/bin/rake db:drop
echo "Creating db..."
/Users/nhelvig/personal/bin/rake db:create
echo "Migrating db..."
/Users/nhelvig/personal/bin/rake db:migrate
echo "Seeding db..."
/Users/nhelvig/personal/bin/rake db:seed
echo "Starting rails server..."
rails s
