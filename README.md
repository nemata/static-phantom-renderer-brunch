# static-phantom-renderer-brunch

Render static pages of your application with phantomjs. It will work with `--optimize` only. It will start a webserver or using the configured host, rendering each path with phantomjs and saving the resulting html into public/:path/index.html.


## Installation
You can install phantomjs with [homebrew](http://mxcl.github.com/homebrew/)

```shell
brew install phantomjs
```

## Config
```coffeescript
	imageoptimizer:
		paths: ['', 'projects', 'projects/[0..3]', 'team'] # required: list of paths to render
		host: http://localhost:8080 # optional, host used to render
```
Paths should be a list of strings, each representing a page to be rendered. You can indicate id ranges with [a..b].
If host is omitted, it will start a node http-server serving the public folder. But you can use this option to start a server by yourself before building the project. 

## Usage
Add `"static-phantom-renderer-brunch": "0.0.5"` to `package.json` of your brunch app.

If you want to use git version of plugin, add
`"static-phantom-renderer-brunch": "git+ssh://git@github.com:nemata/static-phantom-renderer-brunch.git"`.
