require 'ostruct'

module TheForce
  module RemoteIncludes
    @@remotes = []
    
    def self.[](name)
      @@remotes.detect {|remote| remote.name == name }
    end
    
    def self.remotes
      @@remotes
    end
    
    def self.add(attrs)
      attrs[:name] ||= attrs[:url]
      @@remotes << RemoteInclude.new(attrs) unless attrs[:url].blank?
    end
    
    def self.cache_url_with_partial_fallback(url, key, partial = nil)
      begin
        response = Net::HTTP.get_response(URI.parse(url))
        Rails.cache.write(key, response.body) if response.class == Net::HTTPOK
      rescue Exception => e
      ensure
        cache_from_partial(key, partial) if partial and not Rails.cache.read(key)
      end
    end
    
    def self.cache_from_partial(key, partial)
      av = ActionView::Base.new(Rails::Configuration.new.view_path)
      Rails.cache.write(key, av.render(:partial => partial))
    end
    
    def self.recache!
      Array(@@remotes).each do |remote|
        remote.recache!
      end
    end
  end
  
  class RemoteInclude < OpenStruct
    def [](key)
      self.send(key.to_sym)
    end
    
    def key
      name
    end
    
    def value
      Rails.cache.read(key)
    end
    
    def recache!
      RemoteIncludes.cache_url_with_partial_fallback(self.url, self.name, self.backup_partial)
    end
    
    def last_cached_at
      return nil unless Rails.cache.instance_of? ActiveSupport::Cache::FileStore

      File.mtime(Rails.cache.instance_eval("real_file_path('#{self.key}')")) rescue nil
    end
  end
end