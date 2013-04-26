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
    (define _tower-speed (* 1 (* (/ 1 180) pi)))
    
    (define _shot-speed 10)
    (define _shot-radius 2)
    (define _shot-damage 1)
    
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

    (define/public (move-to-x-coord value)
      (set! _x-coord value))
    
    (define/public (move-to-y-coord value)
      (set! _y-coord value))

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
                    (_y-coord (+ _y-coord (* (sin _tower-angle) (+ _radius _tower-length))))
                    (_shot-damage _shot-damage))))
        (set! *list-of-shots* (append (list s) *list-of-shots*))
        (set! _allowed-to-fire #f)
        (new timer%
             (notify-callback reset-allowed-to-fire)
             (interval _freeze-time)
             (just-once? #t))))
    
    (define (get-hits)
      (for-each (lambda (shot)
                  (if (> (+ _radius (send shot get-radius)) (sqrt (+ (sqr (- _x-coord (send shot get-x-coord)))
                                                                     (sqr (- _y-coord (send shot get-y-coord))))))
                      (begin
                        (decrease-health (send shot get-shot-damage))
                        (send shot delete))
                      (void)))
                *list-of-shots*))
    
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
      
      (send dc draw-ellipse (- 0 _radius) (- 0 _radius) (* 2 _radius) (* 2 _radius))
      (send dc draw-line
            (* _radius (cos _tower-angle))
            (* _radius (sin _tower-angle))
            (* (+ _radius _tower-length) (cos _tower-angle))
            (* (+ _radius _tower-length) (sin _tower-angle)))
      
      (let-values (((text-width text-height b s) (send dc get-text-extent (number->string _health))))
        (send dc draw-text (number->string _health) (- 0 (/ text-width 2)) (- 0 (/ text-height 2))))
        
        
        (send dc translate (- 0 _x-coord) (- 0 _y-coord)))
      
      (set! *list-of-players* (append (list this) *list-of-players*))))
  
  
  
  
