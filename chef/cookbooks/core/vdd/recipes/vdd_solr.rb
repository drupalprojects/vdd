cores = []

if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|
    cores << index
  end

end

cores.each do |core_name|

  directory "/etc/solr/#{core_name}/conf" do
    mode  00777
    action :create
    recursive true
  end

  directory "/etc/solr/#{core_name}/data" do
    mode  00777
    action :create
    recursive true
  end

  %w{solrconfig.xml solrconfig_extra.xml elevate.xml mapping-ISOLatin1Accent.txt schema.xml stopwords.txt synonyms.txt protwords.txt solrcore.properties schema_extra_fields.xml schema_extra_types.xml}.each do |conf|
    template "/etc/solr/#{core_name}/conf/#{conf}" do
      source "solr/#{conf}"
      mode 0644
    end
  end

end

template "/etc/solr/solr.xml" do
  source "solr/solr.xml.erb"
  variables(
    cores: cores
  )
  mode 0644
end

service "solr" do
  action :restart
end