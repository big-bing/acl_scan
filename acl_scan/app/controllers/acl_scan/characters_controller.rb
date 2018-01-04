class AclScan::CharactersController < AclScan::ApplicationController

  before_action :load_corporations

  ACL = {
    type: 'common',
    module: '角色权限',
    node: '角色管理',
    acl: [
      { display_name: '展示', actions: [:index], unchangeable_name: 'DISPLAY' },
      { display_name: '新增,修改,操作', actions: [ :edit, :update, :new, :create], unchangeable_name: 'MODIFY' }
    ]
  }

  def index
    @characters = AclScan::Character.ransack(name_cont: params[:q], id_eq: params[:id], corporation_id_eq: current_corporation.id).result.order(id: :asc).page(params[:page]).per(per_page)
  end

  def new
    @character = AclScan::Character.new
    @ability_groups = AclScan::AbilityGroup.all
  end

  def edit
    @character = AclScan::Character.find(params[:id])
    @ability_groups = AclScan::AbilityGroup.all
  end

  def create
    params[:character][:corporation_id] = current_corporation.id
    @character = AclScan::Character.new character_params
    if @character.save
      flash[:succeed] = "创建成功！"
    else
      @errors = @character.errors.full_messages.join("<br/> ")
    end
  end

  def update
    @character = AclScan::Character.find(params[:id])
    if @character.update(character_params)
      flash[:succeed] = "更新成功！"
    else
      @errors = @character.errors.full_messages.join("<br/> ")
    end
  end

  private

  def define_inner_menu
    self.inner_menu_tpl = "shared/inner_menus/characters"
    self.inner_menu_url = '/characters'
    self.context_menu_url = '/characters'
  end

  def character_params
    params.require(:character).permit(:name, :desc, :corporation_id, ability_group_ids: [])
  end

  def load_corporations
    @corporations = [current_corporation]
  end

end
