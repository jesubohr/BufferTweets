# Purpose: To store the current user in a thread safe way
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
