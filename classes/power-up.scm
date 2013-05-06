(define power-up%
  (class object%
    (super-new)
    
    (init-field _length)
    (init-field _duration)
    
    (define _x-coord 0)
    (define _y-coord 0)
    
    
    (field (_player-who-picked-up-power-up #f)
           (_image #f))
    
    (define/public (get-radius)
      (/ _length 2))
    
    (define/public (draw dc)
      (send dc translate _x-coord _y-coord)
      (unless (not _image)
        (send dc draw-bitmap _image (- 0 (/ (send _image get-width) 2)) (- 0 (/ (send _image get-height) 2))))
      (send dc translate (- 0 _x-coord) (- 0 _y-coord)))
    
    (define/public (hit-by-player?)
      (let ((player-hit #f))
        (for-each (lambda (player)
                    (if (>= (+ (/ _length 2) (send player get-radius)) (sqrt (+ (sqr (- _x-coord (send player get-x-coord))) (sqr (- _y-coord (send player get-y-coord))))))
                        (set! player-hit player) 
                        (void)))
                  (send *game-board* get-list-of-players))
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
      (send *game-board* delete-power-up this))
    
    (define (get-hits)
      (for-each (lambda (shot)
                 (if (and (and (< (- _x-coord (/ _length 2)) (send shot get-x-coord)) (< (send shot get-x-coord) (+ _x-coord (/ _length 2)))) 
                          (and (< (- _y-coord (/ _length 2)) (send shot get-y-coord)) (< (send shot get-y-coord) (+ _y-coord (/ _length 2)))))
                     (begin
                       (delete)
                       (send shot delete))
                      (void)))
                (send *game-board* get-list-of-shots)))
    
    (define (random-spawn)
      (let ((random-x-coord (random (send *game-board* width)))
            (random-y-coord (random (send *game-board* height))))
        (if (send (send *game-board* get-map) moveable-at-position random-x-coord random-y-coord this)
            (begin
              (set! _x-coord random-x-coord)
              (set! _y-coord random-y-coord))
            (random-spawn))))
    
    (random-spawn)
    (send *game-board* add-power-up this)
    
    (define/public (update)
      (get-hits)
      (unless (not (hit-by-player?))
        (on-collision (hit-by-player?))))))


;;Ökad hastighet på spelaren
(define power-up-speed%
  (class power-up%
    (super-new)
    (inherit-field _player-who-picked-up-power-up)
    (inherit-field _image)
    
    (set! _image (read-bitmap "images/power-up-speed.png"))
    
    (define/override (reset-power-up)
      (send _player-who-picked-up-power-up change-speed -1))
    
    (define/override (apply-power-up player)
      (send player change-speed 1))))
(add-new-power-up-type power-up-speed%)

;;Ökar spelarens hälsa med 1
(define power-up-health%
  (class power-up%
    (super-new)
    (inherit-field _player-who-picked-up-power-up)
    (inherit-field _image)
    
    (set! _image (read-bitmap "images/power-up-health.png"))
    
    (define/override (apply-power-up player)
      (send player increase-health 1))))
(add-new-power-up-type power-up-health%)







