---
layout: post
title: Placeholder Text in HTML5 - A js fallback
tags:
- Javascript
- Programming
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
A while back I wrote [a post](http://www.morethannothing.co.uk/2009/02/adding-hints-to-html-fields/) including some Javascript to add what I called "hints" to fields in HTML.

Since then, HTML5 has added the same thing, under the name "placeholder text". All you have to do is add "placeholder='Some Text'" and 'Some Text' will appear as a placeholder, disappearing when you focus the field.

While HTML5 support is growing, not every browser supports it (though most do support most of the forms developments) and of course the older browsers don't support it. This means that, if placeholder text is critical to your design (using them as the sole labelling of fields for example) you can't really rely on the placeholder attribute.

To this end, I decided to do a quick rewrite of my script. It now uses a placeholder attribute rather than a hint attribute, and checks to see if placeholder text is supported. If it is, it leaves it alone. If it isn't, it uses the old script as a fallback.

So if the user is using a modern browser they will get the same placeholder text behaviour they have all over the web and even all over their OS. If they don't, then they get the same old behaviour as before. It's win, win.

You can find the new script [here](http://www.morethannothing.co.uk/wp-content/uploads/2010/01/placeholder.js).
