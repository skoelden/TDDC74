(define power-up%
  (class object%
    (super-new)
    
    (init-field _x-coord)
    (init-field _y-coord)
    (init-field _length)
    (init-field _duration)
    
    (define/public (get-length!)
      _length)
    
    (define/public (draw dc)
      (send dc translate _x-coord _y-coord)
      (send dc draw-rectangle (- 0 (/ _length 2)) (- 0 (/ _length 2)) _length _length)
      (send dc translate (- 0 _x-coord) (- 0 _y-coord)))
    
    (define/public (hit-by-player?)
      (for-each (lambda (player)
                  (if (>= (+ (/ _length 2) (send player get-radius!)) (sqrt (+ (sqr (- _x-coord (send player get-x-coord!))) (sqr (- _y-coord (send player get-y-coord!))))))
                      (begin
                        (delete)
                        (on-collision player))
                      (void)))
                  *list-of-players*))
    
    (define/public (reset-power-up player);Hör ihop med on-collsion, gör det motsatta.
      (send player change-speed -1))
    
    (define/public (on-collision player) ;Denna overridas i subklasserna för att få olika typer av power-ups.
     (begin (send player change-speed 1))) ;Vad power-upen ska göra, det här är ett typexmplar
            ;(start-timer! player)))
    
    ;(define (start-timer! player) (new timer% ;Startar en timer som sätter igång reset-power-up när tiden duration har gått.
     ;          (notify-callback (reset-power-up player))
      ;         (interval _duration)
       ;        (just-once? #t)))
           
      ;Det kommenterade ovan fuckade upp endel, får ordna senare            
                        
    (define/public (delete)
      (set! *list-of-power-ups* (remove this *list-of-power-ups* eq?)))
    
    (set! *list-of-power-ups* (append (list this) *list-of-power-ups*))
    
    (define/public (update)
      (hit-by-player?))))
    
    
      