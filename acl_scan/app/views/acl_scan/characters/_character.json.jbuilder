json.extract! character, :name, :id
json.corporation_name character.corporation.try('name')
