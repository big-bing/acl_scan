class AbilityManagesController < ApplicationController

  before_action :load_corporations

  ACL = {
    type: 'common',
    module: '角色权限',
    node: '资源权限设置',
    acl: [
      { display_name: '展示', actions: [:index], unchangeable_name: 'DISPLAY' },
      { display_name: '新增,修改,操作', actions: [ :edit, :update, :new, :create ], unchangeable_name: 'MODIFY' }
    ]
  }

  def index
    @ability_groups = AclScan::AbilityGroup.ransack(name_cont: params[:q], id_eq: params[:id], corporation_id_eq: current_corporation.id).result.order(id: :asc).page(params[:page]).per(per_page)
  end

  def new
    @ability_group = AclScan::AbilityGroup.new
    @abilities = AclScan::Ability.acl.group_by(&:module_name)
  end

  def edit
    @ability_group = AclScan::AbilityGroup.find(params[:id])
    @abilities = AclScan::Ability.acl.group_by(&:module_name)
  end

  def create
    @ability_group = AclScan::AbilityGroup.new ability_group_params
    if @ability_group.save
      flash[:succeed] = "创建成功！"
    else
      @errors = @ability_group.errors.full_messages.join("<br/> ")
    end
  end

  def update
    @ability_group = AclScan::AbilityGroup.find(params[:id])
    if @ability_group.update(ability_group_params)
      flash[:succeed] = "更新成功！"
    else
      @errors = @ability_group.errors.full_messages.join("<br/> ")
    end
  end

  private

  def define_inner_menu
    self.inner_menu_tpl = "shared/inner_menus/characters"
    self.inner_menu_url = '/ability_manages'
    self.context_menu_url = '/characters'
  end

  def ability_group_params
    params.require(:ability_group).permit(:name, :desc, ability_ids: []).merge(corporation_id: current_corporation.id)
  end

  def load_corporations
    @corporations = [current_corporation]
  end

end
