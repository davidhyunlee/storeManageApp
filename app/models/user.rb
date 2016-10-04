class User < ApplicationRecord
	has_secure_password

	has_many :serialized_items
end
