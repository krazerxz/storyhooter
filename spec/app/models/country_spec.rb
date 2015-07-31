require 'rails_helper'

describe Country do
  describe '#all' do
    before do
      allow(YAML).to receive(:load_file).and_return('countries' => ['loads of', 'countries'])
    end

    it 'returns all countries' do
      countries = Country.all
      expect(countries[0].name).to eq 'loads of'
      expect(countries[1].name).to eq 'countries'
    end
  end
end
