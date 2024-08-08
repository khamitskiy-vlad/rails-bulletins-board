20.times do |i|
  i += 1 
  Bulletin.create!(
    title: "asdasfasfasfasf#{i}",
    description: 'afsdfsdfsdgsdgsdgsdgsdgsdgsdgsdgsdg',
    category_id: 1,
    creator_id: 1
  )
end
