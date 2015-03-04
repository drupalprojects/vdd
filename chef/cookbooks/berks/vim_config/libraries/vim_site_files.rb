module VimSiteFiles
  def install_file_to_directory name, version, base_directory, owner = "root", group = "root", force = false
    plugin_directory = ::File.join(base_directory, name)

    if File.exists?(plugin_directory)
      if force
        FileUtils.rm_rf plugin_directory
      else
        log "Skipping #{ plugin_directory }"
        return
      end
    end

    FileUtils.mkdir_p plugin_directory, :mode => 0755

    FileUtils.cd(plugin_directory)
    f = open("http://www.vim.org/scripts/download_script.php?src_id=#{version}")
    local_file = f.meta["content-disposition"].gsub(/attachment; filename=/,"")
    if local_file.end_with? 'vim'
      FileUtils.mkdir_p(File.dirname("plugin"))
      FileUtils.cd("plugin")
    end
    log "Writing #{local_file}"
    File.open(local_file, "w") do |file|
      file << f.read
    end
    if local_file.end_with? 'zip'
      log "Unzip"
      %x(unzip #{local_file})
    end
    if local_file.end_with? 'vba.gz'
      log "Vimball Gzip"
      %x(gunzip #{local_file})
      # launch vim and make it process the vimball the right way:
      unzipped_file = local_file.gsub(/.gz/,"")
      system("cd ../.. ; vim +\"e bundle/#{ name }/#{ unzipped_file }|UseVimball #{ plugin_directory }\" +q")
    elsif local_file.end_with? 'vba.tar.gz'
      log "Vimball Tar Gzip"
      %x(tar zxf #{local_file})
      # launch vim and make it process the vimball the right way:
      unzipped_file = local_file.gsub(/.tar.gz/,"")
      system("cd ../.. ; vim +\"e bundle/#{ name }/#{ unzipped_file }|UseVimball #{ plugin_directory }\" +q")
    elsif local_file.end_with? 'tar.gz'
      log "Tar Gunzip"
      %x(tar zxf #{local_file})
    elsif local_file.end_with? '.gz'
      log "Gunzip"
      %x(gunzip #{local_file})
    end
    if local_file.end_with? 'vim'
      FileUtils.cd("..")
    end
    FileUtils.cd("..")

    FileUtils.chown_R owner, group, plugin_directory
  end
end
