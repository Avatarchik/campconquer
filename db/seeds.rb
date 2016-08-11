# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# This is a little dangerous;
# we have to make sure not to leave any gear lists / refs containing
# obsolete gear names
Gear.destroy_all

# To update the gear database, go to
# https://docs.google.com/spreadsheets/d/1LY9Iklc3N7RkdJKkiuVNsMJ07TFsBi973VmIqgnLO6c/
# select "File > Download As > CSV (current sheet)"
# save as db/gear.csv

f = File.expand_path("gear.csv", File.dirname(__FILE__))
gears = CSV.read(f, headers: :first_row)

gears.each do |row|
  Gear.create!([
                 {
                   name: row["ObjectId"],
                   gear_type: row["Type"].downcase,
                   display_name: row["Item Name"],
                   description: row["Description"],
                   health_bonus: row["Health Bonus"],
                   speed_bonus: row["Speed Bonus"],
                   range_bonus: row["Range Bonus"],
                   gold: row['Gold'],
                   gems: row['Gems'],
                   level: row['Level'],
                   asset_name: row['Asset Name'],
                   icon_name: row['Icon Name']
                 },
               ])

end

words=File.read("/usr/share/dict/words").split
def random_name(words)
  words[rand(words.length)]
end

Player.destroy_all
%w(red blue).each do |team_name|
  50.times do
    p = Player.create!(name: random_name(words), team: team_name)
    Piece.create!(player_id: p.id,
                  team: p.team,
                  role: 'defense',
                  path: [Point.new(x: rand(15), y: rand(10))]
    )
  end
end

# TODO:
#    - seed actual paths
