class Request < ApplicationRecord
	serialize :headers, Hash
  serialize :cookies
  after_create :pusher_trigger

  private
  	def pusher_trigger
  		Pusher.trigger('my-channel', 'new-request', {
        request_id:  self.id,
        remote_ip:   self.remote_ip,
        method:      self.method, 
        params:      self.params,
        scheme:      self.scheme,
        headers:     self.headers,
        cookies:     self.cookies,
        created_at:  self.created_at.strftime('%F %T')
      })
  	end
end
