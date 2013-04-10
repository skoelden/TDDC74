(define player%
  (class object%
    (super-new)

    ;;Datafält
    
    (define _health 10) ;[int]
    (define _x-coord 0) ;[int]
    (define _y-coord 0) ;[int]
    (define _speed 1) ;[int] pixlar/uppdatering
    (define _radius 30) ;[int] radien på kroppen
    

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
      (set! _health (+ _health value)))))
    
    

 