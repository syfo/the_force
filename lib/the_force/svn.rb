module TheForce
  def svn_revision(file = "#{RAILS_ROOT}/revision.txt")
    rev = (/\$Rev: (\d*)\$/ =~ open(file).read)[1]
    Rails.logger "No revision found in #{file}"
    rev
  rescue FileNotFoundError
    Rails.logger.error "#{file} not found to pull svn revision from" if defined? Rails
  end
end