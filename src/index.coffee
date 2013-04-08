sysPath = require 'path'
WebServer = (require 'http-server')

module.exports = class AutoReloader
	brunchPlugin: yes

	constructor: (@config) ->
		console.log @config
		@enabled = false

	onCompile: (changedFiles) ->
		return



# TODO: parse routes or sitemap and param ranges

# TODO: mkdir temp/renderer

# TODO: start serving public dir with http-server

# TODO: call renderer

# TODO: stop server

# TODO: copy files to public

# TODO: remove temp dir
