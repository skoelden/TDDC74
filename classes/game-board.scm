(define game-board%
  (class object%
    (super-new)
    
    (init-field _width)
    (init-field _height)
    (init-field _map)
    (init-field _amount-of-allowed-power-ups)
    
    ;;Listor över saker på spelplanen
    (define *list-of-shots* '())
    (define *list-of-power-ups* '())
    (define *list-of-players* '())
    
    (define _paused #f)
    
    (define/public (set!-map map)
      (set! *map* map))
    
    ;Tick-funkrion som anropas av game-timern
    (define (tick!)
      (send *canvas* refresh))
    
    ;;Game-timer som kör tick var 16:e millisekund 
    (define *game-timer* (new timer% [notify-callback tick!]))
    (send *game-timer* start 16)
    
    ;;Pausfunktion
    (define/public (pause/play)
      (if _paused
          (begin
            (send *game-timer* start 16)
            (set! _paused (not _paused))
            (send *pause-dialog* show #f))
          (begin
            (send *game-timer* stop)
            (set! _paused (not _paused))
            (send *pause-dialog* show #t))))
  
  (define *pause-dialog* (new dialog%
                              [parent *game-window*]
                              [label "Pause menu"]))
  
  (define *play-button* (new button%
                             [label "Play"]
                             [parent *pause-dialog*]
                             [callback (lambda (button event) (pause/play))]))
  
  (send *play-button* show #t)
  
  ;;Returnerar spelplanens bredd
  (define/public (width)
    _width)
  
  ;;Returnerar spelplanens höjd
  (define/public (height)
    _height)
  
  ;;Returnerar spelplanens map
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

