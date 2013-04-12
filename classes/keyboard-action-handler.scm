(define keyboard-action-handler%
  (class object%
    (super-new)
    
    (define _list-of-actions '())
    
    (define (do-actions!)
      (for-each (lambda (key)
                  (assq
                
    
      
      