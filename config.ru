require 'rack/contrib/try_static'
require './cachesettings'

Rack::Mime::MIME_TYPES.merge!({
  '.html' => 'text/html; charset=UTF-8'
})

use CacheSettings,
  :cache_control => 'max-age=86400, public',
  :expires       => 86400

use Rack::TryStatic,
  :root => '_site',
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']

run lambda { [404, {'Content-Type' => 'text/html; charset=UTF-8'}, ['Not Found']] }