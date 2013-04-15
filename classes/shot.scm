(define shot% ;skapar en subklass till object
  (class object% 
    (super-new)
    
    (init-field _radius) 
    (init-field _x-speed)
    (init-field _y-speed)
    (init-field _x-coord)
    (init-field _y-coord) ;Värden som behöver initieras vid skapande av en ny instans
    
    (define/public (update)
      (set! _x-coord (+ _x-coord _x-speed))
      (set! _y-coord (+ _y-coord _y-speed))) ;Uppdaterar skottets koordinater
    
     (define/public (draw dc)
      (send dc translate _x-coord _y-coord)
      (send dc draw-rectangle (- 0 _radius) (- 0 _radius) (* 2 _radius) (* 2 _radius))
      (send dc translate (- 0 _x-coord) (- 0 _y-coord))) ;Ritar ut skottet
    
    (define/public (delete)
      (set! *shot-list* (remove this *shot-list* eq?))) ;Tar bort skottet från listan över alla skott
    
    ))
    