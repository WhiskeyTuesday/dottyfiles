let s:timer_id = 0
let s:themes = []  " Will be populated with available themes

function! GetAirlineThemes()
    " Get list of airline themes from runtime path
    let paths = globpath(&runtimepath, 'autoload/airline/themes/*.vim', 0, 1)
    let s:themes = map(paths, {_, path -> fnamemodify(path, ':t:r')})
    return s:themes
endfunction

function! CycleTheme(timer_id)
    " Initialize themes list if empty
    if empty(s:themes)
        call GetAirlineThemes()
    endif

    " Safely get current theme index, default to -1 if not found
    let current = index(s:themes, get(g:, 'airline_theme', ''))
    if current == -1
        let current = 0  " Start from beginning if current theme not in list
    endif
    
    " Move to next theme (or wrap to start)
    let next = (current + 1) % len(s:themes)
    execute 'AirlineTheme ' . s:themes[next]
endfunction

function! StartThemeCycle(interval)
    " Stop existing timer if any
    if s:timer_id != 0
        call timer_stop(s:timer_id)
    endif
    
    " Initialize themes list if empty
    if empty(s:themes)
        call GetAirlineThemes()
    endif
    
    " Start new timer
    let s:timer_id = timer_start(a:interval, 'CycleTheme', {'repeat': -1})
endfunction

function! StopThemeCycle()
    if s:timer_id != 0
        call timer_stop(s:timer_id)
        let s:timer_id = 0
    endif
endfunction

" Commands to start/stop the cycle
command! -nargs=1 ThemeCycleStart call StartThemeCycle(<args>)
command! ThemeCycleStop call StopThemeCycle()
