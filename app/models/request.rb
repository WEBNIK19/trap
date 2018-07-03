class Request < ApplicationRecord
	serialize :headers, Hash
  serialize :cookies
end
