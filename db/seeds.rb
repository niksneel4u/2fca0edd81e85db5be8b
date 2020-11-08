# frozen_string_literal: true

first_names = %w[albert
                 marie
                 issac
                 galileo]

last_names = %w[einstein
                curie
                newton
                galilei]

emails = ['ae@relativity.com',
          'mc@radiation.com',
          'in@gravity.com',
          'gg@astronomy.com']

first_names.each_with_index do |first_name, index|
  User.find_or_create_by(email: emails[index]) do |user|
    user.first_name = first_name
    user.last_name = last_names[index]
    user.save!
  end
end
