class PleskServer < ApplicationRecord
  has_many :stats, class_name: PleskServerStat
end
