ActiveRecord::Base.transaction do
  TagGroup.find_each do |tag_group|
    TagLayoutTemplate.create!(
      :name              => "#{tag_group.name} in column major order",
      :tag_group         => tag_group,
      :layout_class_name => 'TagLayout::InColumns'
    )
    TagLayoutTemplate.create!(
      :name              => "#{tag_group.name} in row major order",
      :tag_group         => tag_group,
      :layout_class_name => 'TagLayout::InRows'
    )
  end
end
