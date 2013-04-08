system = require 'system'
fs = require 'fs'
_ = require 'underscore'

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
		console.log('FAIL to load the address')
		phantom.exit()
	else
		page.viewportSize = { width: 768, height: 1024 }
		body = page.evaluate () ->
			return document.getElementsByTagName('body')[0].outerHTML

		bodyIndex = index.indexOf index.match(/<body>/)[0]

		header = index.slice 0, bodyIndex

		html = header + body + '</hmtl>'

		#console.log html

		console.log 'writing ', dir + '/' + filename 
		fs.write dir + '/' + filename , html, 'w'

		phantom.exit()
