system = require 'system'
fs = require 'fs'
_ = require 'underscore'
path = require 'path'

page = require('webpage').create()
address = system.args[1]
dir = system.args[2]
filename = system.args[3]

if system.args.length < 3
	console.log 'Usage: render.js <url> <dir> <filename>'
	phantom.exit()

unless fs.isFile 'app/assets/index.html'
	console.error 'no index.html found at \'app/assets\''
	phantom.exit()

index = fs.read 'app/assets/index.html'

page.open address, (status) ->
	if (status isnt 'success')
		console.log('FAIL to load the address', address)
		phantom.exit()
	else
		page.viewportSize = { width: 320, height: 480 }
		body = page.evaluate () ->
			return document.getElementsByTagName('body')[0].outerHTML

		headIndex = index.indexOf '<head>'

		head = index.slice 0, headIndex

		header = page.evaluate () ->
			return document.getElementsByTagName('head')[0].outerHTML

		html = head + header + body + '</hmtl>'

		console.log 'writing', path.join(dir, filename) 
		fs.write path.join(dir, filename), html, 'w'

		phantom.exit()
