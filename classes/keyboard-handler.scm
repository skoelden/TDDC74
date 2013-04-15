(define keyboard-handler%
  (class object%
    (super-new)
    
    (define _list-of-pressed-keys '()) ;Lista över de tangenter som trycks in
    
    (define/public (get-list-of-pressed-keys) ;Hämtar listan med intryckta tangenter
      _list-of-pressed-keys)
    
    (define/public (add-key key)
      (unless (pressed? key)
        (set! _list-of-pressed-keys (append _list-of-pressed-keys (list key))))) ;Lägger till en intryckt tangent till listan över intryckta tangenter om den inte redan är i listan
      
      (define/public (remove-key key)
        (set! _list-of-pressed-keys (remove key _list-of-pressed-keys equal?))) ;Tar bort en tangent från listan över intryckta tangenter
      
      (define/public (pressed? key)
        (let ((found #f))
          (for-each (lambda (element)
                      (if (eq? element key)
                          (set! found #t)
                          (void)))
                    _list-of-pressed-keys)
          found))))                           ;Kollar om en viss tangent är nedtryckt eller ej.
  
  