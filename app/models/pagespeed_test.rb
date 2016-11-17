class PagespeedTest < ApplicationRecord
  belongs_to :domain, touch: true
end
