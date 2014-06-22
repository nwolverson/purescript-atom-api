var gulp = require('gulp');
var purs = require('gulp-purescript');

var PATH = {
  PURS: [ 'src/**/*.purs'
        , 'src/**/*.purs.hs'
        , 'bower_components/purescript-*/src/**/*.purs'
        , 'bower_components/purescript-*/src/**/*.purs.hs'
        ],
  TEST: 'test/**/*.purs',
  DIST: 'dist/'
};

gulp.task('make', function() {
  return gulp.src(PATH.PURS)
    .pipe(purs.pscMake())
    .pipe(gulp.dest(PATH.DIST))
});

gulp.task('watch', function() {
  gulp.watch(PATH.PURS, ['make'])
});

gulp.task('default', ['watch', 'make']);
