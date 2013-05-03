(define (create-power-up)
  (unless (>= (length (send *game-board* get-list-of-power-ups)) 
                     (send *game-board* get-amount-of-allowed-power-ups))
      (new (random-in-list *power-up-types* (random (length *power-up-types*)))
                            (_x-coord (random (send *canvas* get-width)))
                            (_y-coord (random (send *canvas* get-height)))
                            (_length 20)
                            (_duration 10000))))
 
      
(define (random-in-list list int)
  (if (= 0 int)
      (car list)
      (random-in-list (cdr list) (- int 1))))


(define *power-up-types* '()) ;Listan över de power-up typer som skall kunna slumpas ut på spelplanen

(define (add-new-power-up-type power-up)
      (set! *power-up-types* (append (list power-up) *power-up-types*)))
  
    

(new timer%
               (notify-callback create-power-up)
               (interval 10000)
               (just-once? #f))