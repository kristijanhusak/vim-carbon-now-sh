if exists('g:carbon_now_sh_loaded')
  finish
endif

let g:carbon_now_sh_loaded = 1

let g:carbon_now_sh_options = get(g:, 'carbon_now_sh_options', 't=material')
let g:carbon_now_sh_browser = get(g:, 'carbon_now_sh_browser', '')

command! -range=% CarbonNowSh <line1>,<line2>call s:carbonNowSh()

function! s:carbonNowSh() range
  let l:text = s:getVisualSelection()
  let l:browser = s:getBrowser()
  let l:options = escape(g:carbon_now_sh_options, '&')
  let l:filetype = &filetype

  call system(l:browser.' https://carbon.now.sh/\?'.l:options.'\&l='.l:filetype.'\&code='.escape(s:urlEncode(l:text), '%'))
endfunction

function! s:getBrowser() "{{{
  if g:carbon_now_sh_browser !=? ''
    return g:carbon_now_sh_browser
  endif

  if executable('xdg-open')
    return 'xdg-open'
  endif

  if (has('mac') || has('gui_mac') || has('macunix') || has('osx') || has('osxdarwin')) && executable('open')
    return 'open'
  endif

  if has('win32')
    return 'start'
  endif

  if executable('google-chrome')
    return 'google-chrome'
  endif

  if executable('firefox')
    return 'firefox'
  endif

  throw 'Browser not found'
endfunction "}}}

function! s:urlEncode(string) "{{{
  let l:result = ''

  let l:characters = split(a:string, '.\zs')
  for l:character in l:characters
    if l:character ==? ' '
      let l:result = l:result.'%20'
    elseif s:characterRequiresUrlEncoding(l:character)
      let l:i = 0
      while l:i < strlen(l:character)
        let l:byte = strpart(l:character, l:i, 1)
        let l:decimal = char2nr(l:byte)
        let l:result = l:result.'%25'.printf('%02x', l:decimal)
        let l:i += 1
      endwhile
    else
      let l:result = l:result.l:character
    endif
  endfor

  return l:result
endfunction "}}}

function! s:characterRequiresUrlEncoding(character) "{{{
    let l:ascii_code = char2nr(a:character)

    if l:ascii_code >= 48 && l:ascii_code <= 57
        return 0
    elseif l:ascii_code >= 65 && l:ascii_code <= 90
        return 0
    elseif l:ascii_code >= 97 && l:ascii_code <= 122
        return 0
    elseif a:character ==? '-' || a:character ==? '_' || a:character ==? '.' || a:character ==? '~'
        return 0
    endif

    return 1
endfunction "}}}

function! s:getVisualSelection() "{{{
    let [l:line_start, l:column_start] = getpos("'<")[1:2]
    let [l:line_end, l:column_end] = getpos("'>")[1:2]
    let l:lines = getline(l:line_start, l:line_end)

    if len(l:lines) == 0
        return ''
    endif

    let l:lines[-1] = l:lines[-1][:l:column_end - (&selection ==? 'inclusive' ? 1 : 2)]
    let l:lines[0] = l:lines[0][l:column_start - 1:]

    return join(l:lines, "\n")
endfunction "}}}

" vim:foldenable:foldmethod=marker:sw=2
