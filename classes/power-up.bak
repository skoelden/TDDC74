(define power-up%
  (class object%
    (super-new)
    
    (init-field _x-coord)
    (init-field _y-coord)
    (init-field _length)
    (init-field _duration)
    
    (field (_player-who-picked-up-power-up #f))
    
    (define/public (draw dc)
      (send dc translate _x-coord _y-coord)
      (send dc draw-rectangle (- 0 (/ _length 2)) (- 0 (/ _length 2)) _length _length)
      (send dc translate (- 0 _x-coord) (- 0 _y-coord)))
    
    (define/public (hit-by-player?)
      (let ((player-hit #f))
        (for-each (lambda (player)
                    (if (>= (+ (/ _length 2) (send player get-radius!)) (sqrt (+ (sqr (- _x-coord (send player get-x-coord!))) (sqr (- _y-coord (send player get-y-coord!))))))
                        (set! player-hit player) 
                        (void)))
                  *list-of-players*)
        player-hit))
    
    (define (on-collision player)
      (delete)
      (set! _player-who-picked-up-power-up player) 
      (apply-power-up player)
      (start-timer!))
    
    (define (reset-power-up-for-timer)
      (reset-power-up))
    
    (define/public (reset-power-up);Hör ihop med apply-power-up, gör det motsatta.
      (void))
    
    (define/public (apply-power-up player) ;Denna overridas i subklasserna för att få olika typer av power-ups.
      (void))
    
    (define (start-timer!) (new timer% ;Startar en timer som sätter igång reset-power-up när tiden duration har gått.
                                (notify-callback reset-power-up-for-timer)
                                (interval _duration)
                                (just-once? #t)))  
    
    (define/public (delete)
      (set! *list-of-power-ups* (remove this *list-of-power-ups* eq?)))
    
    (define (get-hits)
      (for-each (lambda (shot)
                 (if (and (and (< (- _x-coord (/ _length 2)) (send shot get-x-coord)) (< (send shot get-x-coord) (+ _x-coord (/ _length 2)))) 
                          (and (< (- _y-coord (/ _length 2)) (send shot get-y-coord)) (< (send shot get-y-coord) (+ _y-coord (/ _length 2)))))
                     (begin
                       (delete)
                       (send shot delete))
                      (void)))
                *list-of-shots*))
    
    (set! *list-of-power-ups* (append (list this) *list-of-power-ups*))
    
    (define/public (update)
      (get-hits)
      (unless (not (hit-by-player?))
        (on-collision (hit-by-player?))))))


;;Ökad hastighet på spelaren
(define power-up-speed%
  (class power-up%
    (super-new)
    (inherit-field _player-who-picked-up-power-up)
    
    (define/override (reset-power-up)
      (send _player-who-picked-up-power-up change-speed -1))
    
    (define/override (apply-power-up player)
      (send player change-speed 1))))





