class CacheSettings
  def initialize app, settings
    @app = app
    @settings = settings
  end

  def call env
    res = @app.call(env)
    res[1]['Cache-Control'] = @settings[:cache_control] if @settings.has_key?(:cache_control)
    res[1]['Expires'] = (Time.now + @settings[:expires]).utc.rfc2822 if @settings.has_key?(:expires)
    res
  end
end