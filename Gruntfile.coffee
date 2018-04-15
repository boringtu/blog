module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		watch:
			options:
				livereload: 23333
				dateFormat: (time) ->
					grunt.log.writeln "The watch finished in #{ time }ms at#{ new Date().toString() }"
					grunt.log.writeln 'Waiting for more changes...'
			sync:
				files: [
					'<%= pkg.path.src_resume %>index.pug'
				]
				tasks: ['newer:copy']
			sass:
				files: [
					'<%= pkg.path.src_resume %>src/css/**'
				]
				tasks: ['newer:sass']

		bowercopy:
			options:
				clean: false
			assets:
				options:
					destPrefix: 'assets'
				files: '<%= pkg.bower.copyfiles %>'
		clean:
			dist:
				src: ['./dist/']
			forBower:
				src: '<%= pkg.bower.removefiles %>'
			assets:
				src: ['./assets/']
			css:
				src: ['./dist/css/']
			js:
				src: ['./dist/js/']
			tempCss:
				src: ['./dist/css/temp/']
			tempJs:
				src: ['./dist/js/temp/']

		uglify:
			options:
				preserveComments: 'some'

			forBower:
				files: '<%= pkg.bower.uglifyfiles %>'

			forScript:
				files: [
					expand: true
					cwd: '<%= pkg.path.src.js %>'
					src: ['*.js']
					dest: '<%= pkg.path.dist.js %>'
				]

		sass:
			dist:
				files: [
					expand: true
					cwd: '<%= pkg.path.src_resume %>src/css/'
					src: ['*.sass', '*.scss']
					dest: '<%= pkg.path.dist_resume %>dist/css/'
					ext: '.css'
				]

		cssmin:
			forBower:
				files: '<%= pkg.bower.cssminfiles %>'
			forCompiled:
				files: [
					expand: true
					cwd: '<%= pkg.path.src.css %>compiled/'
					src: [
						'base.css'
						'style.css'
					]
					dest: '<%= pkg.path.dist.css %>'
				]

		autoprefixer:
			#options:
				#browsers: ['last 2 versions', 'ie 9']
				#map: true
			css:
				src: [
					'<%= pkg.path.dist.css %>temp/base.css'
					'<%= pkg.path.dist.css %>style.css'
				]
		
		coffee:
			options:
				sourceMap: false
			root:
				options:
					sourceMapDir: '<%= pkg.path.sourceMap %>'
				files: [
					expand: true
					cwd: '<%= pkg.path.src.coffee %>'
					src: ['*.coffee']
					dest: '<%= pkg.path.src.js %>'
					ext: '.js'
				]

		copy:
			index:
				files:
					'<%= pkg.path.dist_resume %>index.pug': '<%= pkg.path.src_resume %>index.pug'
			dist:
				files: [
					expand: true
					cwd: '<%= pkg.path.src_resume %>'
					src: ['**']
					dest: '<%= pkg.path.dist_resume %>'
				]

	# 任务加载
	require('load-grunt-tasks') grunt, scope: 'devDependencies'

	# 同步输出的 resume 文件
	grunt.registerTask 'default', ['copy:index', 'sass', 'watch']


