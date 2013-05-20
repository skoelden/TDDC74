;;Spelfönstret

(define *game-window* (new frame% 
                         [width 1000]
                         [height 1000]
                         [label "Mexican sombrero fight"]))


;;Funktionen för att rita ut alla objekt. Objekten ombedes updatera sig innan utritning.
 (define (render-fn canvas dc)  
   
;;Ritar kartan
(draw-object (send *game-board* get-map) dc)

;;Ritar ut alla spelare
(for-each (lambda (player)
                (send player update)
(draw-object player dc))
(send *game-board* get-list-of-players))

;;Ritar ut alla skott
(for-each (lambda (obj)
            (send obj update)
            (draw-object obj dc))
          (send *game-board* get-list-of-shots))

;;Ritar ut power-ups
(for-each (lambda (obj)
            (send obj update)
            (draw-object obj dc))
          (send *game-board* get-list-of-power-ups)))

;;En specialvariant av canvas-klassen där on-char metoden har overrideats för att skicka knapptryckningarna till keyboard-handlern
(define game-canvas%
  (class canvas%
    (inherit get-width get-height refresh)
    (super-new)
    
    (define/override (on-char ke)
      (cond
        ((eq? (send ke get-key-code) 'end) (send *game-board* pause/play))
        ((eq? (send ke get-key-code) 'release)
         (send *kh* remove-key (send ke get-key-release-code)))
        (else (send *kh* add-key (send ke get-key-code)))))))

;;Initiering av game-canvas%
(define *canvas* (new game-canvas%
                      [parent *game-window*] 
                      [paint-callback render-fn]
                      (min-height 1000)
                      (min-width 1000)
                      [stretchable-height #f]
                      [stretchable-width #f]
                      ))

(send *game-window* show #t)

;;Funktion som skickar till ett objekt att uppdatera sig
(define (draw-object obj dc)
  (send obj draw dc))

(define (get-game-canvas)
  *canvas*)