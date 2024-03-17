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

# 输出当前的 Node.js 版本
node_version=$(node -v)
echo "Current Node.js version is: $node_version"

npx concurrently "bundle exec puma -C config/puma.rb" "bundle exec sidekiq"
