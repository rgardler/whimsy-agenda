package 'libfreetype6'
package 'libjpeg8'
package 'libfontconfig'

remote_file "#{Chef::Config[:file_cache_path]}/libicu48.deb" do
  source   'http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu48_4.8.1.1-3ubuntu0.5_amd64.deb'
  action   :create_if_missing
  notifies :run, 'execute[dpkg libibu48]', :immediately
end

execute 'dpkg libibu48' do
  command "dpkg -i #{Chef::Config[:file_cache_path]}/libicu48.deb"
  action  :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/phantomjs.tar.bz2" do
  source   'https://s3.amazonaws.com/travis-phantomjs/phantomjs-2.0.0-ubuntu-12.04.tar.bz2'
  action   :create_if_missing
  notifies :run, 'execute[extract phantomjs]', :immediately
end

execute 'extract phantomjs' do
  command "tar -xf #{Chef::Config[:file_cache_path]}/phantomjs.tar.bz2 -C /usr/local/lib"
  action  :nothing
end

link "/usr/local/bin/phantomjs" do
  to "/usr/local/lib/phantomjs"
end
