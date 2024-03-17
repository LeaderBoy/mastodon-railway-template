#!/usr/bin/bash
set -eu


# Step 1: Migrate the database
bundle exec rake db:migrate

# Step 2: Create or update the admin account
# https://docs.joinmastodon.org/admin/setup/#admin-cli
# RAILS_ENV=production bin/tootctl accounts create \
#   "$OWNER_USERNAME" \
#   --email "$OWNER_EMAIL" \
#   --confirmed \
#   --role Owner || true


# 检查concurrently是否安装，如果没有，则安装它
if ! type "concurrently" > /dev/null; then
  npm install concurrently
fi

npx concurrently "bundle exec puma -C config/puma.rb" "bundle exec sidekiq"
