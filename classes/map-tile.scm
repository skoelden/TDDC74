(define map-tile%
  (class object%
    (super-new)
    
    (init-field _x)
    (init-field _y)
    (init-field _width)
    (init-field _height)
    
    (define/public (get-x-coord)
      _x)
    
    (define/public (get-y-coord)
      _y)
    
    (define/public (get-width)
      _width)
    
    (define/public (get-height)
      _height)
    
    (define/public (draw dc)
      (send dc translate (- _x (/ _width 2)) (- _y (/ _height 2)))
      (send dc draw-rectangle 0 0 _width _height)
      (send dc translate (- 0 (- _x (/ _width 2))) (- 0 (- _y (/ _height 2)))))))