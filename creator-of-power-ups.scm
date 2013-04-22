(define (create-power-up)
  (if (null? *list-of-power-ups*)
      (let ((power-up (new power-up%
                            (_x-coord (random (send *canvas* get-width)))
                            (_y-coord (random (send *canvas* get-height)))
                            (_length 20)
                            (_duration 500))))
      (void))))
                            

(new timer%
               (notify-callback create-power-up)
               (interval 10000)
               (just-once? #f))