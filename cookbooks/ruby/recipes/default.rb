# Ruby
apt_repository 'ruby' do
  uri          'ppa:brightbox/ruby-ng'
  distribution 'trusty'
end

%w[build-essential wget libssl-dev libldap2-dev libsasl2-dev 
   libxml2-dev subversion lsof ruby2.2 ruby2.2-dev].each do |p|
  package p
end

