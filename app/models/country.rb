require "hashie"

class Country
  def self.all
    countries = YAML.load_file("#{File.dirname(__FILE__)}/../../config/countries.yml")["countries"]
    countries_as_hash = []
    countries.each_with_index do |item, index| countries_as_hash << {id: index, name: item} end
    as_mash countries_as_hash
  end

  def self.for id
    countries = YAML.load_file("#{File.dirname(__FILE__)}/../../config/countries.yml")["countries"]
    countries[id]
  end

  def self.as_mash array
    array.map {|item| Hashie::Mash.new item }
  end

  private_class_method :as_mash
end
