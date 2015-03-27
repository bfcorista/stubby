require 'sinatra'
require 'json'
require 'faker'

#/patient_data.json
get '/' do
  callback = params.delete('callback') # jsonp

  json = {:patient => {
    :first_name => Faker::Name.first_name,
    :middle_name => Faker::Name.first_name,
    :last_name => Faker::Name.last_name,
    :id => Faker::Code.isbn,
    :organization_id => Faker::Code.isbn,
    :sex => ["M","F","U"].sample,
    :clinic_number => Faker::Code.isbn,
    :spoke_clinic_number => Faker::Code.isbn
  },
  :case => {
    :accessioner_id => Faker::Number.digit,
    :name => Faker::Lorem.word,
    :accessioning_number => Faker::Number.digit,
    :case_type => Faker::Number.digit,
    :physician_notes => Faker::Lorem.sentence,
    :specimens => make_specimens

  }

  }.to_json

  if callback
    content_type :js
    response = "#{callback}(#{json})"
  else
    content_type :json
    response = json
  end
  response

end


def make_specimens()
  specimens = Array.new
  rand(1...5).times do
    specimens << {
      :tissue => Faker::Lorem.word,
      :site => Faker::Address.country,
      :procedure => "PROCEDURE CODE / DESCRIPTION",
      :gross_description => Faker::Lorem.paragraph,
      :slides => make_slides
    }
  end
  specimens
end

def make_slides()
  slides = Array.new
  rand(1...10).times do
    slides << {
      :slide_id => Faker::Number.between(1000,10000),
      :stain => "Stain Goes Here"
    }
  end
  slides
end




