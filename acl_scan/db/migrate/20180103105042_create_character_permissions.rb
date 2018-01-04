class CreateCharacterPermissions < ActiveRecord::Migration[5.1]
  def change

    create_table :characters, comment: '角色' do |t|
      t.bigint :corporation_id
      t.string :name, comment: '名称'
      t.timestamps

      t.index :corporation_id
    end

    create_table :actings, comment: '账号(sub_account)和角色(character)的中间表' do |t|
      t.bigint :sub_account_id
      t.bigint :character_id
      t.timestamps

      t.index :sub_account_id
      t.index :character_id
    end

    create_table :ability_groups, comment: '权限组' do |t|
      t.bigint :corporation_id
      t.string  :name, comment: '名称'
      t.string  :desc, comment: '描述'
      t.integer :ability_ids, default: [], array: true, comment: '资源权限 id'
      t.timestamps

      t.index :corporation_id
    end

    create_table :abilities, comment: '资源权限' do |t|
      t.integer :type_of, comment: '类型：常规，租车，管理，维保，OBD，其它'
      t.string :unchangeable_name, comment: '不能更改的英文名'
      t.string :module_name, comment: '模块名称'
      t.string :node_name, comment: '节点名称'
      t.string :name, comment: '资源总称'
      t.integer :version, comment: '版本'
      t.string :actions, default: [], array: true, comment: 'controller:action'
      t.timestamps
    end

    create_table :character_ability_groups, comment: '角色(characters)和权限组(ability_groups)的中间表' do |t|
      t.bigint :character_id
      t.bigint :ability_group_id
      t.timestamps

      t.index :character_id
      t.index :ability_group_id
    end

  end
end
