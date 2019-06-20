let s:pathSep = '/'
let t:wn = 0

function! Exp()
	let dir = s:makePath()
	let filelist = glob(dir.'*')
	let files = []
	:%d
	execute('normal i'.dir)
	for file in split(filelist, "\n")
		if 'dir' == getftype(file)
			execute('normal o+ '.file[strlen(dir):].s:pathSep)
		else
			call add(files, file)
		endif
	endfor
	for file in files
		execute('normal o- '.file[strlen(dir):])
	endfor
endfunction
command! Ee call Exp()

function! Exe()
	execute(':!start sh "'.s:makePath().'"')
endfunction
command! Ex call Exe()

function! Read()
	let path = s:makePath()
	if 0 < t:wn
		call win_gotoid(t:wn)
	endif
	if 'dir' != getftype(path)
		execute(':e '.path)
	endif
endfunction
command! Er call Read()

function! s:makePath()
	let dir = getline('.')
	let tgr = matchstr(dir, '\v^[+|-]+', 0)
	let base = ''
	if '' != tgr
		let l = strchars(tgr)
		let i = line('.')
		while 0 < strchars(tgr)
			let i -= 1
			let temp = getline(i)
			let tgr = matchstr(temp, '\v^[+|-]+', 0)
			if l > strchars(tgr)
				let l = strchars(tgr)
				let base = substitute(temp, '\v[+|-]+ ', '', '').base
			endif
		endwhile
	elseif '/' != dir[strlen(dir)-1]
		if 'dir' == getftype(dir)
			call setline('.', dir.'/')
			let dir = dir.'/'
		endif
	endif
	return base.substitute(dir, '\v^[+|-]+ ', '', '')
endfunction

function! Close()
	let s = line('.')
	let e = line('$')
	let dir = getline('.')
	let tgr = matchstr(dir, '\v^[+|-]+', 0)
	let i = s
	let l = strlen(tgr)
	while i < e
		let i += 1
		let dir = getline(i)
		let tgr = matchstr(dir, '\v^[+|-]+', 0)
		if l >= strlen(tgr)
			let e = i -1
		endif
	endwhile

	if s < e
		execute(':'.(s+1).','.e.'d')
		execute(':'.s)
	endif
endfunction
command! Ec call Close()

function! PathYank()
	let path = s:makePath()
	let @" = path."\n"
endfunction
command! Ey call PathYank()

function! PathMove(vect)
	if '+' == a:vect
		let v = 1
	else
		let v = -1
	endif
	let dir = getline('.')
	let tgr = matchstr(dir, '\v^[+|-]+', 0)
	let base = ''
	if '' != tgr
		let l = strchars(tgr)
		let i = line('.')
		while 0 < strchars(tgr)
			let i += v
			let temp = getline(i)
			let tgr = matchstr(temp, '\v^[+|-]+', 0)
			if l != strchars(tgr)
				break
			endif
		endwhile
		execute(':'.i)
	endif
endfunction

function! EOpen(arg)
	let path = getline('.')
	if 'v' == a:arg
		let t:wn = bufwinid('%')
		:50vnew
	elseif 'h' == a:arg
		let t:wn = bufwinid('%')
		:20new
	elseif 't' == a:arg
		let t:wn = 0
		:tabnew
	else
		let t:wn = 0
		:enew
	endif
	execute('normal i'.path)
	call Exp()
	nnoremap <buffer> <silent> t :call Tree(0)<CR>
	nnoremap <buffer> <silent> e :call Exp()<CR>
	nnoremap <buffer> <silent> x :call Exe()<CR>
	nnoremap <buffer> <silent> r :call Read()<CR>
	nnoremap <buffer> <silent> c :call Close()<CR>
	nnoremap <buffer> <silent> Y :call PathYank()<CR>
	nnoremap <buffer> <silent> J :call PathMove('+')<CR>
	nnoremap <buffer> <silent> K :call PathMove('-')<CR>
	:setlocal buftype=nowrite
	:setlocal nocursorcolumn
	:setlocal nonumber
	:setlocal nowrap
	if 'u' != a:arg
		:setlocal bufhidden=wipe
	endif
endfunction
command! Eb call EOpen('')
command! EB call EOpen('u')
command! Ev call EOpen('v')
command! Eh call EOpen('h')
command! Etab call EOpen('t')

function! Tree(arg)
	let r = a:arg
	let s = line('.')
	let dir = s:makePath()
	if 'dir' != getftype(dir)
		return
	endif
	call Close()
	let tgr = matchstr(getline(s), '\v^[+|-]+', 0)
	let newTgr = substitute(tgr, '+', '|', 'g')

	let filelist = glob(dir.'*')
	let files = []
	for file in split(filelist, "\n")
		if 'dir' == getftype(file)
			execute('normal o'.newTgr.'+ '.file[strlen(dir):].'/')
			if 0 < r
				call s:SubTree(r -1)
			endif
		else
			call add(files, file)
		endif
	endfor

	for file in files
		execute('normal o'.newTgr.'- '.file[strlen(dir):])
	endfor

	execute(':'.s)

endfunction
command! -nargs=? Et call Tree(<f-args>)

function! s:SubTree(arg)
	let r = a:arg
	let s = line('.')
	let dir = s:makePath()
	let tgr = matchstr(getline(s), '\v^[+|-]+', 0)
	let newTgr = substitute(tgr, '+', '|', 'g')

	let filelist = glob(dir.'*')
	let files = []
	for file in split(filelist, "\n")
		if 'dir' == getftype(file)
			execute('normal o'.newTgr.'+ '.file[strlen(dir):].'/')
			if 0 < r
				call s:SubTree(r -1)
			endif
		else
			call add(files, file)
		endif
	endfor

	for file in files
		execute('normal o'.newTgr.'- '.file[strlen(dir):])
	endfor
endfunction
