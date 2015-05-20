require 'coffee-script/register'

gulp = require 'gulp'
gp = do require 'gulp-load-plugins'

paths = {}
options = {}

paths.build = './resources/build'

paths.coffee = {}
paths.coffee.src = './resources/coffee/**/*.coffee'

paths.scss = {}
paths.scss.src = './resources/scss/index.scss'
paths.scss.src = './resources/scss/**/*.scss'

options.scss = {}
options.scss.outputStyle = 'compressed'

options.coffee = {}
options.coffee.base = true

options.uglify = {}
options.uglify.mangle = false

options.server = {}
options.server.port = '8889'
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

gulp.task 'resources:compile', [
    'coffee:compile'
    'scss:compile'
]

gulp.task 'resources:watch', ->
    gulp.watch paths.coffee.src, ['coffee:compile']
    gulp.watch paths.scss.watch, ['scss:compile']

gulp.task 'server', ->
    gulp.src './'
        .pipe gp.webserver options.server

gulp.task 'default', [
    'server',
    'resources:compile',
    'resources:watch'
]