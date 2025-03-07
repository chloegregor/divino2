# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Destroying all Admin"
AdminUser.destroy_all
puts "Destroying all Boxes"
Box.destroy_all
puts "Destroying all Dividende"
DividendeCuveeColor.destroy_all
puts "Destroying all CuveeColor"
Dividende.destroy_all
puts "Destroying all DCC"
CuveeColor.destroy_all
puts "Destroying all Color"
Color.destroy_all
puts "Destroying all Cuvee"
Cuvee.destroy_all
puts "Destroying all VinyardAppellation"
VinyardAppellation.destroy_all
puts "Destroying all user"
User.destroy_all
puts "Destroying all appellation"
Appellation.destroy_all
puts "Destroying all Vinyard"
Vinyard.destroy_all
puts "destroying all Box Exchange"
BoxExchange.destroy_all
puts "destroying all Exchange"
Exchange.destroy_all



vinyards = [] #ok
appellations = [] #ok
users = [] #ok
vinyardsappellations = [] #ok
cuvees = [] #ok
colors = [] #ok
cuveecolors = [] #ok
dividendes = []
boxes = []


puts "creating vinyards"
Vinyardsnames = ["Château de la Tour", "Domaine de la Romanée-Conti", "Domaine Leflaive", "Domaine Leroy", "Domaine Bagreau", "Vinescence", "Domaine de la Vougeraie"]
Vinyardsnames.each do |vinyardname|
vinyards << Vinyard.create(name: vinyardname, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus")
end

puts "creating users"
pseudos = ["Jean", "Paul", "Jacques", "Marie", "Pierre", "Lucie", "Sophie", "Julie", "Julien"]
pseudos.each_with_index do |pseudo, i|
  user = User.create(pseudo: pseudo, delivery_address: "Address #{i}", email:"#{pseudo}@email.com", password: "password#{i}")
  if user.persisted?
    users << user
  else
    puts "Failed to create user: #{user.errors.full_messages}"
  end
end
puts "Users created: #{users.size}"

puts "creating appellations"
appellationsnames = ["Bourgogne", "Bordeaux", "Champagne", "Alsace", "Beaujolais", "Côtes du Rhône", "Languedoc", "Provence", "Sud-Ouest", "Vallée de la Loire"]
appellationsnames.each do |appellation|
  appellations << Appellation.create(name: appellation)
end

puts "creating vinyardsappellations"

vinyards.each do |vinyard|
  appellationsofvinyard = appellations.sample(rand(1..4))
  appellationsofvinyard.each do |appellation|
    vinyardsappellations << VinyardAppellation.create(vinyard: vinyard, appellation: appellation)
  end

end

winecolors = ["Blanc", "Rouge", "Rosé"]

puts "creating colors"
winecolors.each do |color|
  colors << Color.create(color: color)
end

cuveesnames = ["Cuvée Prestige", "Cuvée Tradition", "Cuvée Excellence", "Cuvée Signature", "Cuvée Millésime", "Cuvée Spéciale", "Cuvée d'Exception", "Cuvée de Prestige", "Cuvée de Tradition", "Cuvée de l'Excellence"]

puts "creating cuvees"
puts "creating cuveecolors"
vinyardsappellations.each do |vinyardappellation|
  appellationscuvees = cuveesnames.sample(rand(1..3))
  appellationscuvees.each_with_index do |cuveename, index|
    cuvee = Cuvee.create(vinyard_appellation: vinyardappellation, name: cuveename)
    cuvees << cuvee
    color = colors[index]
    cuveecolors << CuveeColor.create(cuvee: cuvee, color: color)
  end
end

years1 = (2022..2025).to_a
years2 = (2023..2025).to_a
years = [years1, years2]

puts "creating dividendes"
vinyards.each do |vinyard|
  years.sample.each do |year|
    dividende = Dividende.create(vinyard: vinyard, year: year)
    dividendes << dividende
  end
end

puts "creating boxes"
  dividendes.each do |dividende|
    rand(1..5).times do
      user = users.sample
      boxes << Box.create(user: user, dividende: dividende)
    end
  end
puts "boxes created"

puts "users : #{User.all.size}"
Box.all.each { |b| puts "#{b.id}: #{b.user.pseudo} - #{b.dividende.vinyard.name} - #{b.dividende.year}" }

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
