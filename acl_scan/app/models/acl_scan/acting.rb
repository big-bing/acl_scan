class AclScan::Acting < AclScan::ApplicationRecord

  self.table_name = 'actings'

  belongs_to :character
  belongs_to :sub_account

end

# == Schema Information
#
# Table name: actings
#
#  id             :integer          not null, primary key
#  sub_account_id :integer
#  character_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_actings_on_character_id    (character_id)
#  index_actings_on_sub_account_id  (sub_account_id)
#
