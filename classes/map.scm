(require picturing-programs)
(define map%
  (class object%
    (super-new)
    
    (init-field *list-of-tiles*)
    
    ;;Ritar ut alla map-tiles
    (define/public (draw dc)
      
      (for-each (lambda (tile)
                  (draw-object tile dc))
                *list-of-tiles*))
    
    ;;Kollar om en position är flyttbar till
    (define/public (moveable-at-position x-coord y-coord ref-to-self)
      (let ((moveable #t))
        
        ;;Kollar mot tiles
        (for-each (lambda (tile)
                    (cond
                      ((or
                        (and (>= x-coord (- (send tile get-x-coord) (/ (send tile get-width) 2) (send ref-to-self get-radius))) ; 
                             (<= x-coord (+ (send tile get-x-coord) (/ (send tile get-width) 2) (send ref-to-self get-radius))) ; *|-----|*
                             (>= y-coord (- (send tile get-y-coord) (/ (send tile get-height) 2)))                              ; *|tile |*        
                             (<= y-coord (+ (send tile get-y-coord) (/ (send tile get-height) 2))))                             ; *|-----|*        *
                                                                                                                                ;           Kollar *
                        
                        (and (>= x-coord (- (send tile get-x-coord) (/ (send tile get-width) 2)))                                    ; *******
                             (<= x-coord (+ (send tile get-x-coord) (/ (send tile get-width) 2)))                                    ; |-----|
                             (>= y-coord (- (send tile get-y-coord) (/ (send tile get-height) 2) (send ref-to-self get-radius)))     ; |tile |
                             (<= y-coord (+ (send tile get-y-coord) (/ (send tile get-height) 2) (send ref-to-self get-radius)))))   ; |-----|
                                                                                                                                     ; *******  Kollar ******
                       
                       (set! moveable #f)))
                    
                    (for-each (lambda (corner)
                                (if (>= (send ref-to-self get-radius) (sqrt (+ (sqr (- x-coord (car corner)))
                                                                  (sqr (- y-coord (cdr corner))))))
                                    (set! moveable #f)
                                    (void)))
                              (send tile get-corners)))  
                  *list-of-tiles*)
       
        ;;Kollar mot spelare
        (for-each (lambda (player)
                    (unless (eq? player ref-to-self)
                      (if (>= (+ (send player get-radius) (send ref-to-self get-radius))
                              (sqrt (+ 
                                     (sqr (- (send player get-x-coord) x-coord))
                                     (sqr (- (send player get-y-coord) y-coord)))))
                          (set! moveable #f)
                          (void))))
                  (send *game-board* get-list-of-players))
        
        ;;Kollar mot spelplanens kanter
        (if (or (> (+ x-coord (send ref-to-self get-radius)) (send *game-board* width))
                (> (+ y-coord (send ref-to-self get-radius)) (send *game-board* height))
                (> 0 (- x-coord (send ref-to-self get-radius)))
                (> 0 (- y-coord (send ref-to-self get-radius))))
            (set! moveable #f)
            (void))
        
        moveable))))

