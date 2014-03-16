#!/usr/bin/env coffee
through = require("through")
split = require("split")
require('colors')

run = ->
	process.stdin
		.pipe(split())
		.pipe(through(parseDay))
		.pipe(process.stdout)

parseDay = (text) ->
	console.error 'day:'.red + text.length
	return if !text.length
	day = JSON.parse(text)
	html = """
		<article>
			<h1>#{day.date}</h1>
		</article>
	"""
	for chunk in day.content
		switch chunk.type
			when "paragraph"
				html += "\n\t<p>#{chunk.text}</p>"
			when "code"
				html += "\n\t<pre><code>#{chunk.text}</code></pre>"
			when "heading"
				html += "\n\t<h3>#{chunk.text}</h3>"
			when "list_start"
				html += "\n\t<ul>"
			when "loose_item_start"
				html += "\n\t<li>#{chunk.text}"
			when "list_item_start"
				html += "\n\t<li>"
			when "list_item_end"
				html += "\n\t</li>"
			when "list_end"
				html += "\n\t</ul>"
			when "space"
				html += "\n\t"
			when "text"
				html += "\n\t" + chunk.text.replace(/</g, '&lt;').replace(/>/g, '&gt;')
			else
				throw "Unknown type: " + chunk.type
	@queue html

run()

