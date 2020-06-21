(use std)

;; point
(deftype :point :list[float])

;; make new point
(def point (x:float y:float) :point
	 (list x y) :point)

;; coordinates of the point
(def px (p:point) :float (head p) :float)
(def py (p:point) :float (head (tail p)) :float)

;; coordinates of the point rounded to the nearest integer point
(def pxint (p:point) :int (int (+ (head p) 0.5)))
(def pyint (p:point) :int (int (+ (head (tail p)) 0.5)))

;; add two points
(def padd (p1:point p2:point) :point
	 (point (+ (px p1) (px p2)) (+ (py p1) (py p2))))

(def psub (p1:point p2:point) :point
	 (point (- (px p1) (px p2)) (- (py p1) (py p2))))


;; rotate point around (0.0 0.0)
;; angle is in degrees (!)
(def rotate (dir:point angle:float) :point
	 (set x (px dir))
	 (set y (py dir))
	 (set sina (sin (/ (* 3.14159265 angle) 180.0)))
	 (set cosa (cos (/ (* 3.14159265 angle) 180.0)))
	 (point (- (* x cosa) (* y sina)) (+ (* x sina) (* y cosa))))
