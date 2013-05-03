(define game-board%
  (class object%
    (super-new)
    
    (init-field _width)
    (init-field _height)
    (init-field _map)
    (init-field _amount-of-allowed-power-ups)
    
    (define *list-of-shots* '())
    (define *list-of-power-ups* '())
    (define *list-of-players* '())
    
    
    (define/public (set!-map map)
      (set! *map* map))
    
    (define (tick!)
      (send *canvas* refresh))
    
    (define *my-timer* (new timer% [notify-callback tick!]))
    (send *my-timer* start 16)
        
    (define/public (width)
      _width)
    
    (define/public (height)
      _height)
    
    (define/public (get-map)
      _map)
    
    (define/public (get-amount-of-allowed-power-ups)
      _amount-of-allowed-power-ups)
       
    (define/public (get-list-of-shots)
      *list-of-shots*)
    
    (define/public (get-list-of-players)
      *list-of-players*)
    
    (define/public (get-list-of-power-ups)
      *list-of-power-ups*)
    
    (define/public (add-player-to-list-of-players player) ;Lägger till en spelare i listan över spelare
      (set! *list-of-players* (append (list player) *list-of-players*)))
    
    (define/public (delete-player-from-list-of-players player-to-delete) ;Tar bort en spelare ifrån listan över spelare
      (set! *list-of-players* (remove player-to-delete *list-of-players* eq?)))
    
    (define/public (add-shot-to-list-of-shots shot) ;Lägger till ett skott i listan över skott
      (set! *list-of-shots* (append (list shot) *list-of-shots*)))
    
    (define/public (delete-shot-from-list-of-shots shot-to-delete) ;Tar bort ett skott ifrån listan över skott
      (set! *list-of-shots* (remove shot-to-delete *list-of-shots* eq?)))
    
    (define/public (add-power-up power-up)
      (set! *list-of-power-ups* (append (list power-up) *list-of-power-ups*)))
    
    (define/public (delete-power-up power-up-to-delete)
      (set! *list-of-power-ups* (remove power-up-to-delete *list-of-power-ups* eq?)))))

