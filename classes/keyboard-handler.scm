(define keyboard-handler%
  (class object%
    (super-new)
    
    (define _list-of-pressed-keys '())
    
    (definte/public (get-list-of-pressed-keys)
      _list-of-pressed-keys)
    
    (define/public (add key)
      (set! _list-of-pressed-keys (append _list-of-pressed-keys (list key))))
    
    (define/public (remove-key key)
      (set! _list-of-pressed-keys (remove key _list-of-pressed-keys equal?)))
    
    (define/public (pressed? key)
      (let ((found #f))
        (for-each (lambda (element)
                    (if (eq? element key)
                        (set! found #t)
                        (void)))
                  _list-of-pressed-keys)
        found))))
          
      