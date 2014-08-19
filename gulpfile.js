var
gulp = require('gulp'),
coffee = require('gulp-coffee'),
concat = require('gulp-concat'),
sass = require('gulp-sass'),
gutil = require('gulp-util'),
uglify = require('gulp-uglify'),
minify = require('gulp-minify-css'),
path = require('path'),
express = require('express'),

build = gutil.env.gh ? './gh-pages/' : './build/';

// don't minify/uglify unless we're heading to github
if (!gutil.env.gh) {
    uglify = gutil.noop;
    minify = gutil.noop;
}

gulp.task('coffee', function () {
    return gulp.src('src/scripts/**/*.coffee')
        .pipe(coffee())
        .on('error', gutil.log)
        .pipe(uglify())
        .pipe(concat('jupiter.js'))
        .pipe(gulp.dest(build));
});

gulp.task('sass', function () {
    return gulp.src('src/styles/style.scss')
        .pipe(sass())
        .on('error', gutil.log)
        .pipe(minify())
        .pipe(concat('the.css'))
        .pipe(gulp.dest(build));
});

gulp.task('favicons', function () {
    return gulp.src('src/styles/favicons/*')
        .pipe(gulp.dest(build));
});

gulp.task('index', function () {
    return gulp.src('src/index.html')
        .pipe(gulp.dest(build));
});

gulp.task('build', [
    'index',
    'coffee',
    'sass',
    'favicons'
]);

gulp.task('default', ['build'], function () {
    if (!gutil.env.gh) {
        gulp.watch(['src/**'], ['build']);

        var
        app = express(),
        port = 8888;
        app.use(express.static(path.resolve(build)));
        app.listen(port, function() {
            gutil.log('Listening on', port);
        });
    }
});
