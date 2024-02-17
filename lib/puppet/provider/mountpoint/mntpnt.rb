Puppet::Type.type(:mountpoint).provide :mntpnt do
  desc 'Manages the mountpoint for a filesystem'

  def exists?
    Puppet.debug "#{@resource[:name]} exists but is not a directory." unless File.directory?(@resource[:name].to_s)
    Puppet.debug "#{@resource[:name]} does not exist." unless File.exist?(@resource[:name].to_s)

    File.directory?(@resource[:name].to_s)
  rescue Puppet::ExecutionFailure => e
    Puppet.debug "#{@resource[:name]} does not exist."

    raise e
  end

  def create
    Dir.mkdir(@resource[:name].to_s, 0o0755)
  rescue Puppet::ExecutionFailure => e
    Puppet.debug "exist? mkdir -> #{@resource[:name]}"
    raise e
  end

  def destroy
    Dir.rmdir(@resource[:name].to_s)
  rescue Puppet::ExecutionFailure => e
    Puppet.debug "exist? rmdir -> #{@resource[:name]}"
    raise e
  end
end
