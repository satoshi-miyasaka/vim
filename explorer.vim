function! Tree()
	call Close()
	let s = line('.')
	let dir = getline('.')
	let tgr = matchstr(dir, '\v^[+|-]+', 0)
	let newTgr = substitute(tgr, '+', '|', 'g')
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
	endif

	let dir = base.substitute(dir, '\v^[+|-]+ ', '', '')
	echo dir

	let list = glob(dir.'/*')
	let files = []
	for file in split(list, "\n")
		if 'dir' == getftype(file)
			execute('normal o'.newTgr.'+ '.file[strlen(dir)+1:].'/')
		else
			call add(files, file)
		endif
	endfor
	for file in files
		execute('normal o'.newTgr.'- '.file[strlen(dir)+1:])
	endfor

	execute(':'.s)

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
