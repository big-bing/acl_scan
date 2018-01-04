class AclScan::AbilityGroup < AclScan::ApplicationRecord

  self.table_name = 'ability_group'

  belongs_to :corporation
  has_many :character_ability_groups
  has_many :characters, through: :character_ability_groups
  validates :corporation_id, :name, presence: true

  before_save :update_ability_ids

  def abilities
    Ability.where(id: ability_ids)
  end

  private

  def update_ability_ids
    self.ability_ids = self.ability_ids.to_a.compact
  end

end

# == Schema Information
#
# Table name: ability_groups
#
#  id             :integer          not null, primary key
#  name           :string           comment[名称]
#  desc           :string           comment[描述]
#  corporation_id :integer
#  ability_ids    :integer          default([]), is an Array, comment[资源权限 id]
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_ability_groups_on_corporation_id  (corporation_id)
#
