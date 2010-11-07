require 'ostruct'

module TheForce
  def self.ruby_version
    v = OpenStruct.new
    v.major, v.minor, v.point = *(RUBY_VERSION.split('.').map{|n| n.to_i})
    v.patch = RUBY_PATCHLEVEL

    def v.tiny
      self.point
    end

    def v.is19?
      [major, minor] == [1,9]
    end

    v.freeze
  end
end