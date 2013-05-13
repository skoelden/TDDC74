(define player%
  (class object%
    (super-new)
    
    ;;Datafält
    (init-field right-key)
    (init-field left-key)
    (init-field up-key)
    (init-field down-key)
    (init-field tower-cw-key)
    (init-field tower-ccw-key)
    (init-field shoot-key)
    
    (define _health 10) ;[int]
    (define _x-coord 0) ;[int]
    (define _y-coord 0) ;[int]
    (define _speed 3) ;[int] pixlar/uppdatering
    (define _radius 30)
    
    (define _tower-angle 0) ;[int] vinkel x-axel -> kanontorn medurs i radianer
    (define _tower-length 15) ;[int]
    (define _tower-speed (* 1 (* (/ 1 180) pi)))
    
    (define _shot-speed 25)
    (define _shot-radius 2)
    (define _shot-damage 1)
    
    (define _allowed-to-fire #t)
    (define _freeze-time 1000)
    
    (define _bitmap (read-bitmap "images/sombrero.png"
                                 'unknown/alpha))
    
    (define _amount-of-mez-taken 0)
    
    
    
    ;;Datareturnerare
    
    (define/public (invert-movement-on-other-players)
      (for-each (lambda (player)
                  (if (eq? player this)
                      (void)
                      (send player inverted-movement)))
                (send *game-board* get-list-of-players)))
    
    (define/public (un-invert-movement-on-other-players)
      (for-each (lambda (player)
                  (if (eq? player this)
                      (void)
                      (send player un-inverted-movement)))
                (send *game-board* get-list-of-players)))
                    
    
    (define/public (inverted-movement)
     (set! _amount-of-mez-taken (+ _amount-of-mez-taken 1))
      (if (= _amount-of-mez-taken 1)
          (begin
            (set! _tower-speed (* -1 _tower-speed))
            (set! _speed (* -1 _speed)))
          (void)))
    
    (define/public (un-inverted-movement)
      (set! _amount-of-mez-taken (- _amount-of-mez-taken 1))
      (if (= 0 _amount-of-mez-taken)
          (begin
            (set! _tower-speed (* -1 _tower-speed))
            (set! _speed (* -1 _speed)))
          (void)))
    
    
    ;-----------------------
    ;Beskr: returnerar spelarens hälsa
    ;Arg: VOID
    ;-----------------------
    (define/public (get-health)
      _health)
    
    ;;Metoder
    
    ;-----------------------
    ;Beskr: minskar spelarens hälsa med value
    ;Arg: value[int]
    ;-----------------------
    (define/public (decrease-health value)
      (if (<= (- _health value) 0)
          (send *game-board* delete-player-from-list-of-players this)
          (set! _health (- _health value))))
    
    ;-----------------------
    ;Beskr: ökar spelarens hälsa med value
    ;Arg: value[int]
    ;-----------------------
    (define/public (increase-health value)
      (set! _health (+ _health value)))
    
    ;-----------------------
    ;Beskr: ändrar spelarens x-koordinat
    ;Arg: value[int]
    ;-----------------------
    (define/public (move-x value)
      (if (= 0 value)
          (void)
          (if (send (send *game-board* get-map) moveable-at-position (+ _x-coord value) _y-coord this)
              (set! _x-coord (+ _x-coord value))
              (move-x (- value (/ value (abs value)))))))
    
    
    
    ;-----------------------
    ;Beskr: ändrar spelarens y-koordinat
    ;Arg: value[int]
    ;-----------------------
    (define/public (move-y value)
      (if (= 0 value)
          (void)
          (if (send (send *game-board* get-map) moveable-at-position _x-coord (+ _y-coord value) this)
              (set! _y-coord (+ _y-coord value))
              (move-y (- value (/ value (abs value)))))))
    
    
    ;-----------------------
    ;Beskr: ändrar kanontornets vinkel cw
    ;Arg: value[int]
    ;-----------------------
    (define/public (change-tower-angle value)
      (set! _tower-angle (+ value _tower-angle)))
    
    ;-----------------------
    ;Beskr: ändrar kanontornets längd
    ;Arg: value[int]
    ;-----------------------
    (define/public (change-tower-length value)
      (set! _tower-length (+ value _tower-length)))
    
    (define/public (increase-shot-damage value)
      (set! _shot-damage (+ value _shot-damage)))
    
    (define/public (increase-fire-ratio factor)
      (set! _freeze-time (round (* _freeze-time factor))))
    
    (define/public (increase-tower-speed value)
      (if (>= _tower-speed 0)
          (set! _tower-speed (+ _tower-speed value))
          (set! _tower-speed (- _tower-speed value))))
    
    (define/public (move-to-x-coord value)
      (set! _x-coord value))
    
    (define/public (move-to-y-coord value)
      (set! _y-coord value))
    
    (define/public (get-radius)
      _radius)
    
    (define/public (get-x-coord)
      _x-coord)
    
    (define/public (get-y-coord)
      _y-coord)
    
    (define/public (increase-speed value)
      (if (>= _speed 0)
          (set! _speed (+ _speed value))
          (set! _speed (- _speed value))))

    
    (define (random-spawn)
      (let ((random-x-coord (random (send *game-board* width)))
            (random-y-coord (random (send *game-board* height))))
        (if (send (send *game-board* get-map) moveable-at-position random-x-coord random-y-coord this)
            (begin
              (set! _x-coord random-x-coord)
              (set! _y-coord random-y-coord))
            (random-spawn))))
    
    
    (define (reset-allowed-to-fire)
      (set! _allowed-to-fire #t))
    
    
    (define (fire)        
      (new shot%
           (_radius _shot-radius)
           (_x-speed (* _shot-speed (cos _tower-angle)))
           (_y-speed (* _shot-speed (sin _tower-angle)))
           (_x-coord (+ _x-coord (* (cos _tower-angle) (+ _radius _tower-length))))
           (_y-coord (+ _y-coord (* (sin _tower-angle) (+ _radius _tower-length))))
           (_shot-damage _shot-damage))
      
      (set! _allowed-to-fire #f)
      (new timer%
           (notify-callback reset-allowed-to-fire)
           (interval _freeze-time)
           (just-once? #t)))
    
    (define (get-hits)
      (for-each (lambda (shot)
                  (if (> (+ _radius (send shot get-radius)) (sqrt (+ (sqr (- _x-coord (send shot get-x-coord)))
                                                                     (sqr (- _y-coord (send shot get-y-coord))))))
                      (begin
                        (decrease-health (send shot get-shot-damage))
                        (send shot delete))
                      (void)))
                (send *game-board* get-list-of-shots)))
    
    (define/public (update)
      (move-by-keypress)
      (get-hits))
    
    (define (move-by-keypress)
      (cond
        ((send *kh* pressed? right-key)
         (move-x _speed)))
      (cond
        ((send *kh* pressed? left-key)
         (move-x (- 0 _speed))))
      (cond
        ((send *kh* pressed? up-key)
         (move-y (- 0 _speed))))
      (cond
        ((send *kh* pressed? down-key)
         (move-y _speed)))
      (cond
        ((send *kh* pressed? tower-cw-key)
         (change-tower-angle _tower-speed)))
      (cond
        ((send *kh* pressed? tower-ccw-key)
         (change-tower-angle (- 0 _tower-speed))))
      (cond
        ((send *kh* pressed? shoot-key)
         (unless (not _allowed-to-fire)   
           (fire)))))
    
    
    (define/public (draw dc)
      (send dc translate _x-coord _y-coord)
      
      #|
      (send dc draw-ellipse (- 0 _radius) (- 0 _radius) (* 2 _radius) (* 2 _radius))
      (send dc draw-line
            (* _radius (cos _tower-angle))
            (* _radius (sin _tower-angle))
            (* (+ _radius _tower-length) (cos _tower-angle))
            (* (+ _radius _tower-length) (sin _tower-angle)))|#
      (send dc rotate (- 0 _tower-angle))
      (send dc draw-bitmap _bitmap (/ (- 0 (send _bitmap get-height)) 2) (/ (- 0 (send _bitmap get-width)) 2))
      (send dc rotate _tower-angle)
      
      (let-values (((text-width text-height b s) (send dc get-text-extent (number->string _health))))
        (send dc draw-text (number->string _health) (- 0 (/ text-width 2)) (- 0 (/ text-height 2))))
      
      
      (send dc translate (- 0 _x-coord) (- 0 _y-coord)))
    
    (send *game-board* add-player-to-list-of-players this)
    (random-spawn)))




