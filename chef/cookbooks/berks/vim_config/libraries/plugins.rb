class Chef
  class Recipe
    def add_vim_git_plugin(repository_url)
      node.set[:vim_config][:bundles][:git] =  node[:vim_config][:bundles][:git].dup <<  repository_url unless node[:vim_config][:bundles][:git].include?(repository_url)
    end

    def plugin_dirs_to_delete
      ::Dir.glob(::File.join(node[:vim_config][:bundle_dir], "*")) - all_vim_plugin_directories.collect { |dir_name| ::File.join(node[:vim_config][:bundle_dir], dir_name) }
    end

    def all_vim_plugin_directories
      VimConfig::MercurialPlugins.collect_directory_names(node[:vim_config][:bundles][:hg]) + VimConfig::GitPlugins.collect_directory_names(node[:vim_config][:bundles][:git])
    end
  end
end

module VimConfig
  class Plugins
    class << self
      def collect_directory_names(url_collection)
        url_collection.collect { |url| self.repository_url_to_directory_name(url) }
      end
    end
  end

  class GitPlugins < Plugins
    class << self
      def repository_url_to_directory_name(repository_url)
        repository_url.split("/").last.gsub("\.git", "")
      end
    end
  end

  class MercurialPlugins < Plugins
    class << self
      def repository_url_to_directory_name(repository_url)
        repository_url.split("/").last
      end
    end
  end
end
