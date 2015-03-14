package 'zlib1g-dev'
# FIXME: do this in a more "chef-like" way
script "install whimsy-agenda" do
  interpreter 'bash'
  user 'root'
  cwd '/vagrant'
  code <<-EOH
gem install bundler
bundle install
npm install
rake spec
  EOH
end

