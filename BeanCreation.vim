" A script that creates java bean code.
"
" Example
"
" (input must be tsv format)
" Integer	id
" String	name
"
" (result)
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

" script scope variable definition
let s:numberOfColumns = 2
let s:lineNumber = 1

function! s:println(content)
	call setline(s:lineNumber, a:content)
	let s:lineNumber = s:lineNumber + 1
endfunction

function! s:checkInputFormat(inputLines) abort
	for line in a:inputLines
		let strs = split(line, "\t")	
		if len(strs) != s:numberOfColumns
			throw "Input must be ". s:numberOfColumns ." columns tsv format."
		endif
	endfor
endfunction

function! s:beanCreation(hasAccessor) abort

	let lines = getline(1, "$")
	call s:checkInputFormat(lines)

	%d

	" create fields
	for line in lines
		let type = split(line, "\t")[0]
		let name = split(line, "\t")[1]

		call s:println("/**")
		call s:println(" * " . name . ".")
		call s:println(" */")
		call s:println("private " . type . " " . name . ";")
		call s:println("")
	endfor

	" create accessors
	if a:hasAccessor
		for line in lines
			let type = split(line, "\t")[0]
			let name = split(line, "\t")[1]

			" getter
			call s:println("/**")
			call s:println(" * Gets " . name . ".")
			call s:println(" */")
			call s:println("public " . type . " get" . toupper(strpart(name, 0, 1)) . strpart(name, 1) . "() {")
			call s:println("	return " . name . ";")
			call s:println("}")
			call s:println("")

			" setter
			call s:println("/**")
			call s:println(" * Sets " . name . ".")
			call s:println(" */")
			call s:println("public void set" . toupper(strpart(name, 0, 1)) . strpart(name, 1) . "(" . type . " " . name . ") {")
			call s:println("	this." . name . " = " . name . ";")
			call s:println("}")
			call s:println("")
		endfor
	endif

endfunction

:command! -nargs=1 BeanCreation :call s:beanCreation(<args>)
