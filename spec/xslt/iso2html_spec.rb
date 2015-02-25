require 'spec_helper'

RSpec.describe 'iso2html.xsl' do
  include XmlDocs
  describe 'heading' do
    it 'should stuff' do
      @metadata_html = GeoCombine::Iso19139.new(stanford_iso).to_html
      expect(page).to have_css 'h3'
    end
  end
end
