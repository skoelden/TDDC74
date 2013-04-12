(define *game-window* (new frame% 
                         [width 1000]
                         [height 1000]
                         [label "En ram"]))

(define (render-fn canvas dc)
  (draw-object p dc)
  (draw-object p2 dc))

(define game-canvas%
  (class canvas%
    (inherit get-width get-height refresh)
    (super-new)

    (define/override (on-char ke)
      (if (eq? (send ke get-key-code) #\d)
            (begin
              (send p move-x 1)
              (send (get-game-canvas) refresh))
            (void))
      )))

(define *canvas* (new game-canvas%
                         [parent *game-window*] 
                         [paint-callback render-fn]
                         (min-height 1000)
                         (min-width 1000)
                         [stretchable-height #f]
                         [stretchable-width #f]
                         ))

(send *game-window* show #t)

(define (draw-object obj dc)
  (send obj draw dc))

(define (get-game-canvas)
  *canvas*)