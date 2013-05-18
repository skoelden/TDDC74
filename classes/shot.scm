(define shot%
  (class object% 
    (super-new)
    
    (init-field _radius) 
    (init-field _x-speed)
    (init-field _y-speed)
    (init-field _x-coord)
    (init-field _y-coord)
    (init-field _shot-damage);Värden som behöver initieras vid skapande av en ny instans
    
    (define/public (get-radius)
      _radius)
    
    (define/public (get-x-coord)
      _x-coord)
    
    (define/public (get-y-coord)
      _y-coord)
    
    (define/public (get-shot-damage)
      _shot-damage)
    
    ;;Uppdaterar skottets position
    (define/public (update)
      (moveable?)
      (set! _x-coord (+ _x-coord _x-speed))
      (set! _y-coord (+ _y-coord _y-speed))) ;Uppdaterar skottets koordinater
    
     (define/public (draw dc)
      (send dc translate _x-coord _y-coord)
      (send dc draw-rectangle (- 0 _radius) (- 0 _radius) (* 2 _radius) (* 2 _radius))
      (send dc translate (- 0 _x-coord) (- 0 _y-coord))) ;Ritar ut skottet
    
    ;;Kollar om skottet får röra sig till en viss position. Tar bort skottet ifall den inte får det
    (define (moveable?)
      (if (send (send *game-board* get-map) moveable-at-position _x-coord _y-coord this)
          (void)
          (delete)))
    
    (define/public (delete)
      (send *game-board* delete-shot-from-list-of-shots this)) ;Tar bort skottet från listan över alla skott
    
    ;;Lägger till skottet i listan över skott vid initiering
    (send *game-board* add-shot-to-list-of-shots this)))
    