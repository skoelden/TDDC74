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
    (define _speed 1) ;[int] pixlar/uppdatering
    (define _radius 20)
    
    (define _tower-angle 0) ;[int] vinkel x-axel -> kanontorn medurs i radianer
    (define _tower-length 5) ;[int]
    (define _tower-speed (* 3 (* (/ 1 180) pi)))
    
    (define _shot-speed 5)
    (define _shot-radius 1)
    
    (define _allowed-to-fire #t)
    (define _freeze-time 500)
    
    
    
    ;;Datareturnerare
    
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
      (set! _health (- _health value)))
    
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
      (set! _x-coord (+ _x-coord value)))
    
    ;-----------------------
    ;Beskr: ändrar spelarens y-koordinat
    ;Arg: value[int]
    ;-----------------------
    (define/public (move-y value)
      (set! _y-coord (+ _y-coord value)))
    
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
    
    (define/public (get-radius!)
      _radius)
    
    (define/public (get-x-coord!)
      _x-coord)
    
    (define/public (get-y-coord!)
      _y-coord)
    
    (define/public (change-speed value)
      (set! _speed (+ _speed value)))
    
    
    (define (reset-allowed-to-fire)
      (set! _allowed-to-fire #t))
    
    
    (define (fire)        
      (let ((s (new shot%
                    (_radius _shot-radius)
                    (_x-speed (* _shot-speed (cos _tower-angle)))
                    (_y-speed (* _shot-speed (sin _tower-angle)))
                    (_x-coord (+ _x-coord (* (cos _tower-angle) (+ _radius _tower-length))))
                    (_y-coord (+ _y-coord (* (sin _tower-angle) (+ _radius _tower-length)))))))
        (set! *shot-list* (append (list s) *shot-list*))
        (set! _allowed-to-fire #f)
        (new timer%
             (notify-callback reset-allowed-to-fire)
             (interval _freeze-time)
             (just-once? #t))))
    
    (define/public (update)
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
      (send dc draw-ellipse (- 0 _radius) (- 0 _radius) (* 2 _radius) (* 2 _radius))
      (send dc draw-line
            (* _radius (cos _tower-angle))
            (* _radius (sin _tower-angle))
            (* (+ _radius _tower-length) (cos _tower-angle))
            (* (+ _radius _tower-length) (sin _tower-angle)))
      
      (send dc translate (- 0 _x-coord) (- 0 _y-coord)))
    
    (set! *list-of-players* (append (list this) *list-of-players*))))



