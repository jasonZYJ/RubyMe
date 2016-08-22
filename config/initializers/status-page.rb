StatusPage.configure do
  # self.use :cache #TODO will have cache function in the future
  self.use :redis
  self.use :sidekiq
  self.use :database

  self.interval = 10
end
