require 'spec_helper'

RSpec.describe 'iso2html.xsl' do
  include XmlDocs
  describe 'Indentification Information' do
    it 'contains Indentification Information and sub headings' do
      @metadata_html = GeoCombine::Iso19139.new(stanford_iso).to_html
      expect(page).to have_css 'h3', text: 'Identification Information'
      expect(page).to have_css 'h4', text: 'Citation Information'
      expect(page).to have_css 'h4', text: 'Description'
      # expect(page).to have_css 'h4', text: 'Credit'
      expect(page).to have_css 'h4', text: 'Status'
      expect(page).to have_css 'h4', text: 'Point of Contact'
    end
    describe 'Citation Information' do
      it 'contains appropriate elements' do
        @metadata_html = GeoCombine::Iso19139.new(stanford_iso).to_html
        expect(page).to have_css 'dt', text: 'Title'
        expect(page).to have_css 'dd', text: 'Hydrologic Sub-Area Boundaries: Russian River Watershed, California, 1999'
        expect(page).to have_css 'dt', text: 'Date'
        # expect(page).to have_css 'dd', text: 'September 1, 2002 - publication'
        expect(page).to have_css 'dt', text: 'Identifier'
        # expect(page).to have_css 'dd', text: 'Code: http://purl.stanford.edu/bb338jh0716'
        expect(page).to have_css 'dt', text: 'Responsible Party'
      end
    end
  end
end
