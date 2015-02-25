require 'spec_helper'

RSpec.describe 'fgdc2html.xsl' do
  include XmlDocs
  describe 'headings' do
    it 'contains appropriate headings' do
      @metadata_html = GeoCombine::Fgdc.new(tufts_fgdc).to_html
      expect(page).to have_css 'h3', text: 'Identification Information'
      expect(page).to have_css 'h3', text: 'Data Quality Information'
      expect(page).to have_css 'h3', text: 'Spatial Reference Information'
      expect(page).to have_css 'h3', text: 'Entity and Attribute Information'
      expect(page).to have_css 'h3', text: 'Distribution Information'
      expect(page).to have_css 'h3', text: 'Metadata Reference Information'
    end
  end
end
