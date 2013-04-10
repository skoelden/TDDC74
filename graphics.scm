(define *game-window* (new frame% 
                         [width 300]
                         [height 200]
                         [label "En ram"]))

(define (render-fn canvas dc)
  (draw-object p dc)
  (draw-object p2 dc))

(define *canvas* (new canvas%
                         [parent *game-window*] 
                         [paint-callback render-fn]
                         (min-height 100)
                         (min-width 100)
                         [stretchable-height #f]
                         [stretchable-width #f]
                         ))

(send *game-window* show #t)

(define (draw-object obj dc)
  (send obj draw dc))

  