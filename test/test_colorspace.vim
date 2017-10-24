let s:testdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
execute 'lcd' s:testdir
execute 'source' s:testdir.'/test.vim'

let s:eps = 0.000001

fun! Test_CS_srgb2xyz238238239()
  let [x,y,z] = colortemplate#colorspace#srgb2xyz(238, 238, 239)
  " Values as computed by http://colormine.org/color-converter
  call assert_true(81.41441852841255 - s:eps < x && x < 81.41441852841255 + s:eps)
  call assert_true(85.55820926290504 - s:eps < y && y < 85.55820926290504 + s:eps)
  call assert_true(93.88474076133308 - s:eps < z && z < 93.88474076133308 + s:eps)
endf

fun! Test_CS_srgb2cielab238238239()
  let [L,a,b] = colortemplate#colorspace#rgb2cielab(238, 238, 239)
  " Values as computed by http://colormine.org/color-converter
  call assert_true(94.12313115610355 - s:eps < L && L < 94.12313115610355 + s:eps)
  call assert_true(0.18264247948240886 - s:eps < a && a < 0.18264247948240886 + s:eps)
  call assert_true(-0.49221569623207895 - s:eps < b && b < -0.49221569623207895 + s:eps)
endf

fun! Test_CS_delta_eeeeef()
  let l:res = colortemplate#colorspace#approx('#eeeeef')
  call assert_equal('#eeeeef', l:res['color'])
  call assert_equal(255, l:res['index'])
  call assert_equal('#eeeeee', l:res['approx'])
  call assert_true(0.54422 - s:eps <= l:res['delta'] && l:res['delta'] <= 0.54422 + s:eps)
endf

fun! Test_CS_hex_delta_e()
  let l:delta = colortemplate#colorspace#hex_delta_e('#767676', '#7c6f64')
  call assert_true(7.889685 - s:eps < l:delta && l:delta < 7.889685 + s:eps)
endf

call RunBabyRun('CS')
