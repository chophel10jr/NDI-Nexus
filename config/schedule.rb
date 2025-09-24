every 1.day, at: '1:00 am' do
  command "cd /var/www/NDI-Nexus && /home/ndi_nexus/.asdf/shims/bundle exec rails runner 'CreateSessionJob.perform_now' >> /var/www/NDI-Nexus/log/cron.log 2>&1"
end
