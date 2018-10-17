tag = Tag.where(title: 'Today').first_or_create!

task = Task.where(title: 'Wash laundry').first_or_create!
task.update(tags: [tag])