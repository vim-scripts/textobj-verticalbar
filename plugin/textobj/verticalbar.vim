" textobj-verticalbar - Text objects for vertical bar.
" Version: 0.0.3
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
"	 0.0.3	2009-09-17	Fixed bug with multi-byte characters.
"	 0.0.2	2009-05-27	Change behavior when a text under the cursor is '|'.
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

function! s:get_vb_pos(lnum) "{{{
	return [searchpos('|', 'bcn', a:lnum), searchpos('|', 'cn', a:lnum)]
endfunction "}}}

function! s:searchpos_from(pattern, flag, from) "{{{
	if a:from == [0,0]
		return [0,0]
	endif
	let cpos = getpos('.')
	call setpos('.', [0, a:from[0], a:from[1],0])
	let s = searchpos('.', a:flag, a:from[0])
	call setpos('.', cpos)
	return s
endfunction "}}}

" exclude vertical bar itself.
function! s:select_i()  "{{{
	let lnum = line('.')
	let [s,e] = s:get_vb_pos(lnum)
	if s == e
		return 0
	endif
	let s = s:searchpos_from('.', '', s)
	if s == e
		return 0
	endif
	if e != [0,0]
		let e = s:searchpos_from('.', 'b', e)
	endif
	return ['v'
	\, [ 0, lnum, s[1] <= 0    ? 1                : s[1], 0]
	\, [ 0, lnum, e[1] < s[1] ? len(getline('.')) : e[1], 0]
	\]
endfunction "}}}

" include vertical bar itself.
function! s:select_a()  "{{{
	let lnum = line('.')
	let [s,e] = s:get_vb_pos(lnum)
	if s == e
		return 0
	endif
	return ['v'
	\, [ 0, lnum, s[1] <= 0    ? 1                 : s[1], 0]
	\, [ 0, lnum, e[1] <= s[1] ? len(getline('.')) : e[1], 0]
	\]
endfunction "}}}

"}}}

" Fin.  "{{{
let g:loaded_textobj_verticalbar = 1
"}}}

" __END__
" vim: foldmethod=marker
