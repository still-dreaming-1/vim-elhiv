function! L_s(str)
    let s = {}
    let s.str = a:str
    let s.len = len(s.str)

    function! s.contains(needle)
        return stridx(self.str, a:needle) != -1
    endfunction

    " returns -1 or 0 based index
    function! s.index_of(needle, ...)
        let start_index = 0
        if a:0 > 1
            let start_index = a:2
        endif
        return stridx(self.str, a:needle, start_index)
    endfunction

    " returns -1 or index
    function! s.ridx(needle, ...)
        if a:0 > 0
            let start = a:1
            return l_s#new(self.str).ridx(a:needle, start)
        endif
        return l_s#new(self.str).ridx(a:needle)
    endfunction

    function! s.starts_with(str)
        return l_s#new(self.str).starts_with(a:str)
    endfunction

    function! s.skip(count)
        return L_s(self.str[a:count : ])
    endfunction

    function! s.remove_end()
        return L_s(l_s#new(self.str).remove_end().str)
    endfunction

    function! s.ends_with(needle)
        let needle_length = len(a:needle)
        let my_length = len(self.str)
        if needle_length > my_length
            return 0
        endif
        return a:needle ==# self.str[ my_length - needle_length : ]
    endfunction

    function! s.escape(chars)
        return L_s(escape(self.str, a:chars))
    endfunction

    " returns an S with spaces, \n, and tabs removed from the beginning and end
    function! s.trim()
        let ret_s = L_s(self.str)
        let chars_to_trim = [' ', "\n", "\t"]
        for char in chars_to_trim
            while ret_s.starts_with(char)
                let ret_s = ret_s.remove_start()
            endwhile
            while ret_s.ends_with(char)
                let ret_s = ret_s.remove_end()
            endwhile
        endfor
        return ret_s
    endfunction

    function! s.remove_start()
        return L_s(self.str[1 : ])
    endfunction

    function! s.after(needle)
        let i = self.index_of(a:needle)
        if i == -1
            return L_s('')
        endif
        return L_s(self.str[i + len(a:needle) : ])
    endfunction

    function! s.after_last(str)
        let i = self.ridx(a:str)
        if i == -1
            return L_s('')
        endif
        return L_s(self.str[i + len(a:str) : ])
    endfunction

    function! s.before_last(str)
        let i = self.ridx(a:str)
        if i == -1
            return L_s(self.str)
        endif
        let i -= 1
        if i <= 0
            return L_s('')
        endif
        return L_s(self.str[0 : i])
    endfunction

    " this helps when you are using strings that are interpreted as Vim patterns, but you don't want them to be
    function! s.get_no_magic()
        let escaped_string = escape(self.str, '\')
        " see :h \V for info about this very nomagic trick
        return L_s('\V'.escaped_string)
    endfunction

    function! s.replace(needle, new_needle, ...)
        if len(a:needle) == 0
            return L_s(self.str)
        endif
        let start_index = 0
        if a:0 > 2
            let start_index = a:3
        endif
        if self.len <= start_index
            return L_s(self.str)
        endif
        let needle_index = self.index_of(a:needle, start_index)
        if needle_index < 0
            return L_s(self.str)
        endif
        let result_start_string = ''
        if needle_index > 0
            let result_start_string = self.str[0 : needle_index - 1]
        endif
        let result_end_string = ''
        if self.len > needle_index + len(a:needle)
            let result_end_string = self.str[needle_index + len(a:needle) : ]
        endif
        let result = L_s(result_start_string . a:new_needle . result_end_string)
        return result.replace(a:needle, a:new_needle, start_index + len(a:new_needle))
    endfunction

    function! s.to_pascal_case()
        let i = 0
        let started_new_word = 1
        let pascal_str = ''
        while i < self.len
            if started_new_word
                let pascal_str .= toupper(self.str[i])
                let started_new_word = 0
            elseif self.str[i] ==# '_'
                let started_new_word = 1
            else
                let pascal_str .= self.str[i]
            endif
            let i = i + 1
        endwhile
        let pascal_s = L_s(pascal_str)
        if pascal_s.ends_with('DB')
            let pascal_s = pascal_s.remove_end()
            let pascal_s = L_s(pascal_s.str . 'b')
        endif
        return pascal_s
    endfunction

    return s
endfunction
