echo 'Pubspec Assist has been sourced.'

" Find autoload script and source it.
" call pubspecassist#example()

fun! PubspecAssist()
  lua for k in pairs(package.loaded) do if k:match("^pubspec%-assist") then package.loaded[k] = nil end end
  lua require('pubspec-assist').createFloatingWindow()
endfun

fun! Pub()
  call inputsave()
  let package = input('Enter search string: ')
  call inputrestore()
  let res = webapi#http#get(printf('https://pub.dev/api/search?q='.package))
  let obj = webapi#json#decode(res.content)
  redraw
  let  packages = obj.packages
  echom packages[0]
  let c = 0
  for package in packages
    echom c.') '. package.package
    let c+=1
  endfor
  call inputsave()
  let selection = input('Enter the number: ')
  call inputrestore()
  let details = webapi#json#decode(webapi#http#get(printf('https://pub.dev/api/packages/'.packages[selection].package)).content)
  let packstr = details.name.' : '.details.latest.version
  redraw
  echom packstr
  let @"=packstr
endfun

nmap <leader>dl :lua print("hello lua")<CR>
" nmap <leader>dk :!dart hello.dart<CR>
nmap <leader>dp :call PubspecAssist()<CR>
nmap <leader>dh :call Pub()<CR>
