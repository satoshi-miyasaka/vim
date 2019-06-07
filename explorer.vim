function! Tree()
	let s = line('.')
	let dir = getline('.')
	let tgr = matchstr(dir, '\v^[+|-]+', 0)
	let newTgr = substitute(tgr, '+', '|', 'g')
	let base = ''
	if '' != tgr
		let l = strchars(tgr)
		let i = line('.')
		while 0 < strchars(tgr)
			let temp = getline(i)
			let tgr = matchstr(temp, '\v^[+|-]+', 0)
			if l > strchars(tgr)
				let l = strchars(tgr)
				let base = substitute(temp, '\v[+|-]+ ', '', '').base
			endif
			let i -= 1
		endwhile
	endif

	let dir = base.substitute(dir, '\v^[+|-]+ ', '', '')

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
