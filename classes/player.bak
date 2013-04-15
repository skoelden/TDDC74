(define player%
  (class object%
    (super-new)

    ;;Datafält
    
    (define _health 10) ;[int]
    (define _x-coord 0) ;[int]
    (define _y-coord 0) ;[int]
    (define _speed 1) ;[int] pixlar/uppdatering
    (define _radius 20)
    (define _tower-angle 0) ;[int] vinkel x-axel -> kanontorn medurs i radianer
    (define _tower-length 5) ;[int]
    

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
    ;Beskr: ändrar kanontornets vinkel
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
    
    (define/public (draw dc)
      (send dc translate _x-coord _y-coord)
      (send dc draw-ellipse (- 0 _radius) (- 0 _radius) (* 2 _radius) (* 2 _radius))
      (send dc draw-line
            (* _radius (cos _tower-angle))
            (* _radius (sin _tower-angle))
            (* (+ _radius _tower-length) (cos _tower-angle))
            (* (+ _radius _tower-length) (sin _tower-angle)))
            
      (send dc translate (- 0 _x-coord) (- 0 _y-coord)))))
    
    

 