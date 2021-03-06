module Jekyll
  module StubFilter
    def stub(input)
      if input.has_key? 'stub'
        '<p>' + input['stub'] + '</p>'
      else
        input['content'].split("\n")[0]
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::StubFilter)
