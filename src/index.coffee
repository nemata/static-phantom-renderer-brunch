sysPath = require 'path'
exec = require('child_process').exec
fs = require 'fs'
_ = require 'underscore'

module.exports = class StaticPhantomRenderer
	brunchPlugin: yes

	constructor: (@config) ->
		@enabled = @config.optimize
		@paths = @config.staticPhantomRenderer.paths
		@host = @config.staticPhantomRenderer.host
		@public = @config.paths.public
		@loadPaths = []

	onCompile: (data, path, callback) ->
		if @enabled
			# parse paths
			_.each @paths, (path) =>
				if path.match /\[\d+\.{2}\d+\]/
					pathPrefix = path.replace /\[.*/, ''
					min = path.replace /.*\[/, ''
					max = min.replace /.*\.\./, ''
					min = parseInt min.replace /\.\..*/, ''
					max = parseInt max.replace /\]/, ''
					for i in [min..max]
						@loadPaths.push pathPrefix + i
				else
					@loadPaths.push path

			# starting server, unless host given
			unless @host
				@host = 'http://localhost:8080/'
				@server = exec "http-server #{@public}", (error, stdout, stderr) =>
					if error
						@server.kill()
						return error
					console.log '[static-renderer] ' + stdout if stdout
					console.log '[static-renderer] err: ' + stderr if stderr
				console.log '[static-renderer] starting webserver and serving ' + @public
			else
				@host += '/' unless @host.match /\/$/
				console.log '[static-renderer] loading paths form ' + @host

			@render =>
				@server.kill() if @server

			return

	render: (fn)->
		procs = []
		_.each @loadPaths, (path) =>
			# calling the renderer for each path
			filename = path + '/index.html'
			proc = exec "phantomjs node_modules/static-phantom-renderer-brunch/lib/renderer.js #{@host}##{path} #{@public} #{filename}", (error, stdout, stderr) ->
				console.log '[static-renderer] ' + stdout if stdout
				console.log '[static-renderer] err: ' + stderr if stderr
				console.log 'exec error: ' + error if error
			procs.push proc
			proc.on 'close', =>
				procs.pop()
				if procs.length is 0
					fn.call() if fn
