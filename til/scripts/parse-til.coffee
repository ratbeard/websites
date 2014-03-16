#!/usr/bin/env coffee
path = require('path')
fs = require('fs')
marked = require('marked')
require('colors')

tilFile = path.join(process.env.HOME, "notes", "til.md")
text = fs.readFileSync(tilFile, 'utf8')
lexer = new marked.Lexer()
tokens = lexer.lex(text)
#console.log tokens
days = []
day = null
for token in tokens
	if token.type == 'heading' && token.depth == 1
		day = {
			date: null
			content: []
			text: ->
				@content.map((c) ->
					if c.type == 'list_item'
						"- " + c.text
					else if c.type == 'code'
						c.text.grey
					else
						c.text
				).filter((c) -> c).join("\n")
		}
		days.push(day)
		day.date = token.text
	else
		day.content.push(token)


for day in days
	#console.log "\n"
	#console.log day.date.red
	#console.log day.text()
	process.stdout.write(JSON.stringify(day) + "\n")

