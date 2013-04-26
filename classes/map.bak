(define map%
  (class object%
    (super-new)
    
    (init-field path)
    
    (define _map-bitmap (read-bitmap path))
    
    (define/public (get-map-bitmap)
      _map-bitmap)
    
    (define/public (get-map-width)
      (send _map-bitmap get-width))
    
    (define/public (get-map-height)
      (send _map-bitmap get-height))
    
    (define/public (moveable-at-position? x y)
      (let ((color (get-pixel-color x y _map-bitmap)))
        (not (and (= (color-red color) 0)
             (= (color-green color) 0)
             (= (color-blue color) 0)))))
    
    (define/public (draw dc)
      (send dc draw-bitmap _map-bitmap 0 0))))

