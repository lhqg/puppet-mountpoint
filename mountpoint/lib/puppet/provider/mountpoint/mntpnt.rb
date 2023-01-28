Puppet::Type.type(:mountpoint).provide :mntpnt do
  desc "Manages the mountpoint for a filesystem"

  def exists?
    begin
      if File.exist?("#{@resource[:name]}")
        if File.directory?("#{@resource[:name]}")
          return true
        else
          Puppet.debug "#{@resource[:name]} exists but is not a directory"
          return false
        end
      else
        Puppet.debug "#{@resource[:name]} does not exist"
        return false
      end
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "#{@resource[:name]} does not exist"
      return false
    end
  end

  def create
    begin
      Dir.mkdir("#{@resource[:name]}", 0755)

    rescue Puppet::ExecutionFailure => e
      Puppet.debug "exist? mkdir -> #{@resource[:name]}"
      fail "mkdir failed -> #{e.inspect}"
      return {}
    end
  end

  def destroy
    begin
      Dir.rmdir("#{@resource[:name]}")
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "exist? rmdir -> #{@resource[:name]}"
      fail "rmdir had an error -> #{e.inspect}"
      return {}
    end
  end
end

