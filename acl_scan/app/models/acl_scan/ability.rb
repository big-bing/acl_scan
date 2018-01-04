class AclScan::Ability < AclScan::ApplicationRecord

  self.table_name = 'abilities'

  validates :name, uniqueness: {scope: [:type_of, :module_name, :node_name]}
  scope :no_acl, -> {ransack(unchangeable_name_end: '_no_acl').result}
  scope :acl, -> {ransack(unchangeable_name_not_end: '_no_acl').result}

  enum type_of: {
    common: 1,
    maintain: 2,
    rent: 3,
    obd: 4
  }

  ACL_CACHE_KEY     = "Ability::newest_acl".freeze
  NO_ACL_CACHE_KEY     = "Ability::newest_no_acl".freeze
  VERSION_CACHE_KEY = "Ability::version".freeze

  class << self

    def delete_acl_cache
      Rails.cache.delete(ACL_CACHE_KEY)
      Rails.cache.delete(NO_ACL_CACHE_KEY)
      Rails.cache.delete(VERSION_CACHE_KEY)
    end

    def version
      Rails.cache.fetch(VERSION_CACHE_KEY) do
        maximum(:version)
      end
    end

    def latest_no_acl_actions
      Rails.cache.fetch(NO_ACL_CACHE_KEY) do
        max_ver = maximum(:version)
        no_acl.where(version: max_ver).pluck('unnest(actions)')
      end
    end

  end

end

# == Schema Information
#
# Table name: abilities
#
#  id                :integer          not null, primary key
#  type_of           :integer          comment[类型：常规，租车，管理，维保，OBD，其它]
#  unchangeable_name :string           comment[不能更改的英文名]
#  module_name       :string           comment[模块名称]
#  node_name         :string           comment[节点名称]
#  name              :string           comment[资源总称]
#  version           :integer          comment[版本]
#  actions           :string           default([]), is an Array, comment[controller:action]
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
