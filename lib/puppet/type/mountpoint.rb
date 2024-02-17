Puppet::Type.newtype(:mountpoint) do
  ensurable

  newparam(:name) do
    desc 'The name of the mount point for a filesystem.'
    isnamevar

    validate do |value|
      unless Pathname.new(value).absolute?
        raise ArgumentError, "#{value} is not valid mount point."
      end
    end
  end
end
