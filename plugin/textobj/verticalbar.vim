" textobj-verticalbar - Text objects for vertical bar.
" Version: 0.0.2
" Author: ampmmn(htmnymgw <delete>@<delete> gmail.com)
" URL: http://d.hatena.ne.jp/ampmmn
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" ----
" history
"	 0.0.2	2009-05-27	Change action, when a text under the cursor is '|'.
"	 0.0.1	2009-05-26	initial release.
" ----

if exists('g:loaded_textobj_verticalbar')  "{{{
  finish
endif
"}}}

" Interface  "{{{

call textobj#user#plugin('verticalbar', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-i': ['iv', 'i<bar>'],  '*select-i-function*': 's:select_i',
\        'select-a': ['av', 'a<bar>'],  '*select-a-function*': 's:select_a',
\      }
\    })
"}}}

" Misc.  "{{{

function! s:select(offset) "{{{
	let lnum = line('.')
	let s = searchpos('|', 'bcn', lnum)
	let e = searchpos('|', 'cn', lnum)
	if s[1] == e[1]
		return 0
	endif
	return ['v'
	\, [ 0, lnum, s[1] <= 0    ? 1                 : s[1] + a:offset, 0]
	\, [ 0, lnum, e[1] <= s[1] ? len(getline('.')) : e[1] - a:offset, 0]
	\]
endfunction "}}}

" exclude vertical bar itself.
function! s:select_i()  "{{{
	return s:select(1)
endfunction "}}}

" include vertical bar itself.
function! s:select_a()  "{{{
	return s:select(0)
endfunction "}}}

"}}}

" Fin.  "{{{
let g:loaded_textobj_verticalbar = 1
"}}}

" __END__
" vim: foldmethod=marker
