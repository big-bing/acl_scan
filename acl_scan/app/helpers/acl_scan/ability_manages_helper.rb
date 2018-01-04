module AclScan::AbilityManagesHelper

  def module_authorize_acl(module_name)
    return true if current_user.is_admin
    AclScan::Ability.where(version: AclScan::Ability.version).exists?(module_name: module_name, id: current_user.had_ability_ids)
  end

  def authorize_acl(action, controller = current_controller)
    action_str = "#{ controller }:#{ action }"
    abilities_check_authorization(action_str)
  end

  def current_controller
    params[:controller]
  end

  def abilities_check_authorization(action_str)
    return true if current_user.is_admin
    AclScan::Ability.latest_no_acl_actions.include?(action_str) || current_user.permissions.include?(action_str)
  end

end
