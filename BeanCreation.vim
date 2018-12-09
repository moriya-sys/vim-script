" A script that create java bean code.
"
" example
"
" (input)
" Integer id
" String name
"
" (output)
" /**
"  * id
"  */
" private Integer id;
" 
" /**
"  * name
"  */
" private String name;
"

let lines = getline(1, '$')

%d

let lineNumber = 1
for line in lines
	call setline(lineNumber, '/**')
	let lineNumber = lineNumber + 1
	call setline(lineNumber, ' * ' . split(line, ' ')[1])
	let lineNumber = lineNumber + 1
	call setline(lineNumber, ' */')
	let lineNumber = lineNumber + 1
	call setline(lineNumber, 'private ' . line. ';')
	let lineNumber = lineNumber + 1
	call setline(lineNumber, '')
	let lineNumber = lineNumber + 1
endfor

