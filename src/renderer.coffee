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

page.open address, (status) ->
	if (status isnt 'success')
		console.log('FAIL to load the address')
		phantom.exit()
	else
		html = page.evaluate () ->
			return document.getElementsByTagName('html')[0].outerHTML

		console.log 'writing ', dir + '/' + filename 
		fs.write dir + '/' + filename , html, 'w'

		phantom.exit()
