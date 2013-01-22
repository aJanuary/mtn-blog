require 'rack/contrib/try_static'

Rack::Mime::MIME_TYPES.merge!({
  '.html' => 'text/html; charset=UTF-8'
})

use Rack::TryStatic,
  :root => '_site',
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']

run lambda { [404, {'Content-Type' => 'text/html'}, ['Not Found']] }