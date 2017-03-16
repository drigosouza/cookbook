remote_file "#{Chef::Config[:file_cache_path]}/webtatic-release-6.rpm" do
    source "https://mirror.webtatic.com/yum/el6/latest.rpm"
    action :create
end

package "webtatic repository" do
    source "#{Chef::Config[:file_cache_path]}/webtatic-release-6.rpm"
    action :install
end

package "php70w" do
  action :install
end

package "php70w-fpm" do
  action :install
end

package "php70w-mysqlnd" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-gd" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-soap" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-mbstring" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-devel" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-bcmath" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-pear" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-mcrypt" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-opcache" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

package "php70w-xml" do
  action :install
  notifies :restart, "service[php-fpm]", :immediately
end

template '/etc/php-fpm.d/www.conf' do
  source 'php70-www.conf'
  notifies :restart, "service[php-fpm]", :immediately
  notifies :restart, "service[newrelic-daemon]", :immediately
end

template '/etc/php.ini' do
  source 'php70-php.ini'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[php-fpm]", :immediately
  notifies :restart, "service[newrelic-daemon]", :immediately
end

service "php-fpm" do
  action [ :enable, :start ]
  supports :restart => true
end