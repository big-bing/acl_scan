json.items do
  json.array! @characters, partial: 'character', as: :character
end
