# io.js
remote_file "#{Chef::Config[:file_cache_path]}/iojs.tar.xz" do
  source   'https://iojs.org/dist/v1.5.0/iojs-v1.5.0-linux-x64.tar.xz'
  action   :create_if_missing
  notifies :run, 'execute[extract iojs]', :immediately
end

execute 'extract iojs' do
  command "tar -xf #{Chef::Config[:file_cache_path]}/iojs.tar.xz -C /usr/local/lib"
  action  :nothing
end

link "/usr/local/bin/iojs" do
  to "/usr/local/lib/iojs-v1.5.0-linux-x64/bin/iojs"
end
link "/usr/local/bin/node" do
  to "/usr/local/lib/iojs-v1.5.0-linux-x64/bin/node"
end
link "/usr/local/bin/npm" do
  to "/usr/local/lib/iojs-v1.5.0-linux-x64/bin/npm"
end
