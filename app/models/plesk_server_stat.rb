class PleskServerStat < ApplicationRecord
  belongs_to :plesk_server, touch: true
end
