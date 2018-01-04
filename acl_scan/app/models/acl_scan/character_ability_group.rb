class AclScan::CharacterAbilityGroup < AclScan::ApplicationRecord

  self.table_name = 'character_ability_group'

  belongs_to :role
  belongs_to :ability_group

end

# == Schema Information
#
# Table name: character_ability_groups
#
#  id               :integer          not null, primary key
#  character_id     :integer
#  ability_group_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_character_ability_groups_on_ability_group_id  (ability_group_id)
#  index_character_ability_groups_on_character_id      (character_id)
#
