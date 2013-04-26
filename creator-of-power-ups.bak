(define (create-power-up)
  (if (null? *list-of-power-ups*)
      (new power-up-speed%
                            (_x-coord (random (send *canvas* get-width)))
                            (_y-coord (random (send *canvas* get-height)))
                            (_length 20)
                            (_duration 10000))
      (void)))
                            
(define power-up-types (list
                        power-up-speed%))
(new timer%
               (notify-callback create-power-up)
               (interval 10000)
               (just-once? #f))