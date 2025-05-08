env :PATH, ENV['PATH']
env :RAILS_ENV, 'development'

every 1.day, at: '1:00 am' do
  command "cd /home/tenzin-chophel/Documents/Projects/NDI/NDI-Nexus && bundle exec rails runner 'CreateSessionJob.perform_now'"
end
