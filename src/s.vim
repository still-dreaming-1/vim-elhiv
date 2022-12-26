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

    function! s.to_camel_case()
        return self.to_camel_or_pascal_case(1)
    endfunction

    function! s.to_pascal_case()
        return self.to_camel_or_pascal_case(0)
    endfunction

    function! s.to_camel_or_pascal_case(to_camel)
        let i = 0
        let updated_str = ''
        let previous_was_underscore = 0
        let previous_was_lowercase = 0
        let previous_was_uppercase = 0
        let processed_first_letter = 0
        while i < self.len
            let current_char = self.str[i]
            let current_is_underscore = current_char ==# '_'
            let current_is_uppercase = tolower(current_char) !=# current_char
            let current_is_lowercase = toupper(current_char) !=# current_char

            " if updated_str ==# 'your' && previous_was_underscore
                " echo 'at your, current_char = ' . current_char . ' current_is_underscore = ' . current_is_underscore . ' current_is_lowercase = ' . current_is_lowercase . ' current_is_uppercase = ' . current_is_uppercase
                " echo 'processed_first_letter = ' . processed_first_letter
            " endif

            if !processed_first_letter
                if a:to_camel && (i == 0 || previous_was_underscore)
                    let updated_str .= tolower(current_char)
                else
                    let updated_str .= toupper(current_char)
                endif
            elseif i == 0 && current_is_underscore
                let updated_str .= current_char
            elseif !previous_was_lowercase && !previous_was_uppercase && (current_is_lowercase || current_is_uppercase)
                let updated_str .= toupper(current_char)
            elseif current_is_uppercase && previous_was_uppercase
                let updated_str .= tolower(current_char)
            elseif !current_is_underscore
                let updated_str .= current_char
            endif

            let previous_was_underscore = current_is_underscore
            let previous_was_uppercase = current_is_uppercase
            let previous_was_lowercase = current_is_lowercase
            if !processed_first_letter && (current_is_lowercase || current_is_uppercase)
                let processed_first_letter = 1
            endif
            let i = i + 1
        endwhile
        return L_s(updated_str)
    endfunction

    function! s.to_screaming_snake_case()
        let i = 0
        let screaming_snake_str = ''
        let previous_was_underscore = 0
        let previous_was_uppercase = 0
        let previous_was_lowercase = 0
        while i < self.len
            let current_char = self.str[i]
            let current_is_underscore = current_char ==# '_'
            let current_is_uppercase = tolower(current_char) !=# current_char
            let current_is_lowercase = toupper(current_char) !=# current_char

            if i != 0 && !current_is_underscore && !previous_was_underscore
                if previous_was_lowercase && current_is_uppercase
                    let screaming_snake_str .= '_'
                elseif !previous_was_lowercase && !previous_was_uppercase
                    if current_is_lowercase || current_is_uppercase
                        let screaming_snake_str .= '_'
                    endif
                elseif (previous_was_lowercase || previous_was_uppercase) && (!current_is_lowercase && !current_is_uppercase)
                    let screaming_snake_str .= '_'
                endif
            endif
            let screaming_snake_str .= toupper(current_char)

            let previous_was_underscore = current_is_underscore
            let previous_was_uppercase = current_is_uppercase
            let previous_was_lowercase = current_is_lowercase
            let i = i + 1
        endwhile
        return L_s(screaming_snake_str)
    endfunction

    function! s.smart_to_camel_or_pascal_case()
        let i = 0
        let starts_with_underscore = 0
        let has_underscore_not_at_start = 0
        let first_letter_is_lowercase = 0
        let first_letter_is_uppercase = 0
        while i < self.len
            let current_char = self.str[i]
            let current_is_underscore = current_char ==# '_'
            let current_is_lowercase = toupper(current_char) !=# current_char
            let current_is_uppercase = tolower(current_char) !=# current_char
            if !first_letter_is_lowercase && !first_letter_is_uppercase
                if current_is_lowercase
                    let first_letter_is_lowercase = 1
                elseif current_is_uppercase
                    let first_letter_is_uppercase = 1
                endif
            endif
            if i == 0
                if current_is_underscore
                    let starts_with_underscore = 1
                endif
            elseif current_is_underscore
                let has_underscore_not_at_start = 1
            endif
            let i = i + 1
        endwhile
        if starts_with_underscore
            return self.to_camel_case()
        endif
        if has_underscore_not_at_start
            if first_letter_is_lowercase
                return self.to_camel_case()
            elseif first_letter_is_uppercase
                return self.to_pascal_case()
            endif
        else
            if first_letter_is_lowercase
                return self.to_pascal_case()
            elseif first_letter_is_uppercase
                return self.to_camel_case()
            endif
        endif
        return L_s(self.str)
    endfunction

    return s
endfunction
