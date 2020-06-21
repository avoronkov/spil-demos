; (use std)
(use "dict.lisp")

(deftype :fractal :any)

;; parse fractal
(def fractal-parse (s:str) :fractal
	 (parse s) :fractal)


;; get axiom of the fractal
(def axiom (f:fractal) :str
	 (dict.getdefault "axiom" (do f :dict[str,str]) "") :str)


;; get rules of the fractal
(def rules (f:fractal) :dict[str,str]
	 (dict.getdefault "rules" (do f :dict[str,list]) '()) :dict[str,str])


;; get number of iterations of the fractal
(def iters (f:fractal) :int
	 (dict.getdefault "iters" (do f :dict[str,int]) 0))


;; get rotation angle of the fractal (in degrees)
(def angle (f:fractal) :float
	 (dict.getdefault "angle" (do f :dict[str,float]) 90.0))


;; expand axiom of fractal using rules
(def expand-fractal (f:fractal) :str
	 (expand-fractal f (iters f)))
(def expand-fractal (f:fractal iters:int) :str
	 (expand-fractal~ (axiom f) (rules f) iters))

(def expand-fractal~ (moves:str rules:dict[str,str] 0) :str moves)
(def expand-fractal~ (moves:str rules:dict[str,str] iters:int) :str
	 (expand-fractal~ (expand~ moves rules "") rules (- iters 1)))

(def expand~ ('()       rules:dict[str,str] acc:str) :str acc)
(def expand~ (moves:str rules:dict[str,str] acc:str) :str
	 (set h (head moves))
	 (set next (dict.getdefault h rules h))
	 (expand~ (do (tail moves) :str) rules (do (append acc next) :str)))

;  (set' file (open "koch-snowflake.txt"))
;  
;  (set fr (fractal-parse file))
;  
;  (print "fractal:" fr)
;  (print "axiom:" (axiom fr))
;  (print "rules:" (rules fr))
;  (print "iters:" (iters fr))
;  (print "angle:" (angle fr))
;  
;  (print "snake 0:" (expand-fractal fr 0))
;  (print "snake 1:" (expand-fractal fr 1))
;  (print "snake 2:" (expand-fractal fr 2))
;  (print "snake 3:" (expand-fractal fr 3))
;  (print "snake 4:" (expand-fractal fr 4))
