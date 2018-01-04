json.items do
  json.array! @ability_groups, partial: 'ability_manage', as: :ability_manage
end
