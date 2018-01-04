class AclScan::Character < AclScan::ApplicationRecord

  self.table_name = 'characters'

  belongs_to :corporation
  has_many :actings
  has_many :sub_accounts, through: :actings
  has_many :character_ability_groups
  has_many :ability_groups, through: :character_ability_groups

end

# == Schema Information
#
# Table name: characters
#
#  id             :integer          not null, primary key
#  corporation_id :integer
#  name           :string           comment[名称]
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_characters_on_corporation_id  (corporation_id)
#
