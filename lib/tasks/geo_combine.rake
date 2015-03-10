require 'find'
require 'net/http'
require 'json'
require 'rsolr'

namespace :geocombine do
  desc 'Clone all OpenGeoMetadata repositories'
  task :clone do
    ogm_api_uri = URI('https://api.github.com/orgs/opengeometadata/repos')
    ogm_repos = JSON.parse(Net::HTTP.get(ogm_api_uri)).map{ |repo| repo['git_url']}
    ogm_repos.each do |repo|
      if repo =~ /^git:\/\/github.com\/OpenGeoMetadata\/edu.*/
        system "mkdir -p tmp && cd tmp && git clone #{repo}"
      end
    end
  end
  desc '"git pull" OpenGeoMetadata repositories'
  task :pull do
    Dir.glob('tmp/*').map{ |dir| system "cd #{dir} && git pull origin master" if dir =~ /.*edu.*./ }
  end
  desc 'Index all of the GeoBlacklight documents'
  task :index do
    SOLR_URL = ENV.fetch('SOLR_URL', 'http://127.0.0.1:8983/solr')
    solr = RSolr.connect :url => SOLR_URL
    Find.find('tmp') do |path|
      if path =~ /.*geoblacklight.xml$/
        doc = File.read(path)
        begin
          solr.update data: doc
          solr.commit
        rescue RSolr::Error::Http => error
          puts error
        end
      end
    end
  end
end
