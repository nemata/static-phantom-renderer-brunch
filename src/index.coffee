sysPath = require 'path'
WebServer = (require 'http-server')
_ = require 'underscore'

module.exports = class StaticPhantomRenderer
	brunchPlugin: yes

	constructor: (@config) ->
		@enabled = @config.optimize
		@paths = @config.staticPhantomRenderer.paths

	onCompile: (data, path, callback) ->
		#if @enabled
			# parse paths
			console.log 'onCompile'
			loadPaths = []
			_.each @paths, (path) ->
				if path.match /\[\d+\.{2}\d+\]/
					pathPrefix = path.replace /\[.*/, ''
					min = path.replace /.*\[/, ''
					max = min.replace /.*\.\./, ''
					min = parseInt min.replace /\.\..*/, ''
					max = parseInt max.replace /\]/, ''
					for i in [min..max]
						loadPaths.push pathPrefix + i
				else
					loadPaths.push path
			console.log loadPaths



			return



# TODO: parse routes or sitemap and param ranges

# TODO: mkdir temp/renderer

# TODO: start serving public dir with http-server

# TODO: call renderer

# TODO: stop server

# TODO: copy files to public

# TODO: remove temp dir
