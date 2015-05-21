require 'coffee-script/register'

gulp = require 'gulp'
gp = do require 'gulp-load-plugins'

paths = {}
options = {}

paths.build = './../client/build'

paths.coffee = {}
paths.coffee.src = './../client/coffee/**/*.coffee'

paths.scss = {}
paths.scss.src = './../client/scss/index.scss'
paths.scss.watch = './../client/scss/**/*.scss'

options.scss = {}
options.scss.outputStyle = 'compressed'

options.coffee = {}
options.coffee.base = true

options.uglify = {}
options.uglify.mangle = false

options.server = {}
options.server.livereload = false

gulp.task 'scss:compile', ->
    gulp.src paths.scss.src
        .pipe gp.sourcemaps.init()
            .pipe gp.sass(options.scss).on 'error', gp.sass.logError
        .pipe gp.sourcemaps.write('./maps')
        .pipe gulp.dest paths.build

gulp.task 'coffee:compile', ->
    gulp.src paths.coffee.src
        .pipe gp.sourcemaps.init()
            .pipe(gp.coffee(options.coffee)
                .on 'error', (error) ->
                    console.log error
            )
            .pipe gp.uglify options.uglify
            .pipe gp.concat 'app.js'
        .pipe gp.sourcemaps.write('./maps')
        .pipe gulp.dest paths.build

gulp.task 'client:compile', [
    'coffee:compile'
    'scss:compile'
]

gulp.task 'server', ->
    process.chdir('./server')
    server = gp.liveServer ['./index.js']
    server.start()

    gulp.watch paths.coffee.src, (event) ->
        gulp.run ['coffee:compile']
        server.notify()

    gulp.watch paths.scss.watch, (event) ->
        gulp.run ['scss:compile']
        server.notify()

gulp.task 'default', [
    'client:compile',
    'server'
]