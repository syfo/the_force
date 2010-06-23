module TheForce
  def svn_revision(file = nil)
    (svn_revision_from_file if file) || svn_revision_from_repo
  end

  #expects file created with svn:keywords  
  def svn_revision_from_file(file)
    m = (/\$Rev: (\d*)\$/ =~ open(file).read)
    m and m[1]
  end
  
  def svn_revision_from_repo
    m = `svn info`.match(/Last Changed Rev:\s*(\d*)$/)
    m and m[1]
  end
end